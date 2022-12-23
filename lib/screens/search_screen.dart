import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  // ♦ Constructor:
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ♦ Controller:
  final TextEditingController searchController = TextEditingController();

  // ♦ Variable:
  bool isShowUsers = false;

  // ♦ The "dispose()" Method:
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ♦ APP BAR:
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
                const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              debugPrint(_);
            },
          ),
        ),
      ),

      // ♦ BODY:
      body: isShowUsers
          ? FutureBuilder(
              // ♦ Detting "Users" Collection:
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {

                // ♦ Checking:
                if (!snapshot.hasData) {
                  // ♦ Displaying "Loading Indicator":
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // ♦ List:
                return ListView.builder(
                  // ♦ Getting the "Items Number":
                  itemCount: (snapshot.data! as dynamic).docs.length,

                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          // ♦ Getting the "photoUrl" from "Database":
                          (snapshot.data! as dynamic).docs[index]['photoUrl'],
                        ),
                        radius: 16,
                      ),
                      title: Text(
                        // ♦ Getting the "Username" from "Database":
                        (snapshot.data! as dynamic).docs[index]['username'],
                      ),
                    );
                  },
                );
              },
            )
          : const Text('Posts'),
    );
  }
}
