import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/profile_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_flutter/utils/global_variable.dart';


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
          ?
            // ♦ "Users Search" Builder:
            FutureBuilder(
              // ♦ Getting "Users" Collection:
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),

              // ♦ "User" Builder:
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

                    // ♦ "Rectangular Area" of a "Material"
                    //    → that "Responds" to "Touch":
                    return InkWell(
                      // ♦ "Redirection" to "Profile Screen":
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            uid: (snapshot.data! as dynamic).docs[index]['uid'],
                          ),
                        ),
                      ),

                      // ♦ Single Fixed-Height "Row"
                      //   → that contains a "Text" and an "Icon":
                      child: ListTile(
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
                      ),
                    );
                  },
                );
              },
            )
          :
            // ♦ "Posts Search" Builder:
            FutureBuilder(
              // ♦ Getting "Posts" Collection:
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('datePublished')
                  .get(),

              // ♦ "Post" Builder:
              builder: (context, snapshot) {
                // ♦ Checking:
                if (!snapshot.hasData) {
                  // ♦ Displaying "Loading Indicator":
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // ♦ "Post Grid View" Builder:
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,

                  // ♦ Getting the "Items Number"
                  itemCount: (snapshot.data! as dynamic).docs.length,

                  itemBuilder: (context, index) => Image.network(
                    // ♦ Getting the "Post URL" from "Database":
                    (snapshot.data! as dynamic).docs[index]['postUrl'],
                    fit: BoxFit.cover,
                  ),

                  staggeredTileBuilder: (index) => MediaQuery.of(context)
                      .size
                      .width >
                      webScreenSize
                      ? StaggeredTile.count(
                      (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                      : StaggeredTile.count(
                      (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),

                  // ♦ Spacing:
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              },
            ),
    );
  }
}
