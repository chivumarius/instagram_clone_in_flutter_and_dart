import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),

      // ♦ "Listening" to "Changes" in "Real Time":
      body: StreamBuilder(
        // ♦ Colling "snapshots()"
        //   → for "Real Time Listening"
        //   → from "posts" Collection
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),

        // ♦ Getting the "Builder" with "2 Functions":
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          // ♦ Checking the "Connection State":
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ♦ Displaying the "Circular Loading Indicator":
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ♦ Displaying the "List" of "Posts":
          return ListView.builder(
            // ♦ "Counting" the "Items" of the "List":
            itemCount: snapshot.data!.docs.length,

            itemBuilder: (ctx, index) => Container(
              // ♦ "Rendering" the "Data" oh the "PostCard()":
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
