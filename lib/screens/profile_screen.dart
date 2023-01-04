import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {

  // ♦ Property:
  final String uid;

  // ♦ Constructor:
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // ♦ Properties:
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  // ♦ The "initState()" Method:
  @override
  void initState() {
    super.initState();
    // ♦ Calling the Function:
    getData();
  }


  // ♦ The "getData()" Function
  //    → for "Getting Data":
  getData() async {

    // ♦ Enable "isLoading" Prop:
    setState(() {
      isLoading = true;
    });

    // ♦ Blocks:
    try {
      // ♦ Getting "User Data" → from "Database":
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // Get Post Length:
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      // ♦ "Getting Data"
      //    → from "Database":
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }

    // ♦ Disable "isLoading" Prop:
    setState(() {
      isLoading = false;
    });
  }

  // ♦ The "buildStatColumn()" Function
  //    → for creating "Columns"
  //    → with the "Number" of "Posts", "Followers" and "Following":
  Column buildStatColumn(int num, String label) {

    // ♦ Column:
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,

      // ♦ The "Column Content"
      children: [
        // ♦ Counting:
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        // ♦ Column "Label":
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    // ♦ Conditional Return:
    return isLoading
        ?
          // ♦ Showing the "Circular Progress Indicator":
          const Center(
            child: CircularProgressIndicator(),
          )
        :
          Scaffold(

            // ♦ The "App Bar":
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text(
                'username',
              ),
              centerTitle: false,
            ),

            // ♦ The "App Body":
            body: ListView(
              children: [
                // ♦ "Profile Photo" &
                //   "Posts", "Followers" and "Following" Columns
                //   "Username", "Biography" and "Edit Profile" Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [

                          // ♦ Profile Photo:
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              // Getting "photoUrl" → from "Database":
                              userData['photoUrl'],
                            ),
                            radius: 40,
                          ),

                          // Getting all the "Row  Spacing":
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                // ♦ "Posts", "Followers" and "Following"
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,

                                  // ♦ The "Counting"
                                  //    → for the "Posts", "Followers" and "Following":
                                  children: [
                                    // ♦ Getting "postLen", "followers" and "following"
                                    //   → from "Database":
                                    buildStatColumn(postLen, "posts"),
                                    buildStatColumn(followers, "followers"),
                                    buildStatColumn(following, "following"),
                                  ],
                                ),

                                // ♦ The "Follow Button":
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // ♦ Conditional Rendering of the "Follow Button":
                                    FirebaseAuth.instance.currentUser!.uid ==
                                        widget.uid
                                        ?
                                          // ♦ "Sign Out" Button:
                                          FollowButton(
                                            text: 'Edit Profile',
                                            backgroundColor: mobileBackgroundColor,
                                            textColor: primaryColor,
                                            borderColor: Colors.grey,
                                            function: () {},
                                          )
                                        :
                                          isFollowing
                                        ?
                                          // ♦ "Unfollow" Button:
                                          FollowButton(
                                            text: 'Unfollow',
                                            backgroundColor: Colors.white,
                                            textColor: Colors.black,
                                            borderColor: Colors.grey,
                                            function: () {},
                                          )
                                        :
                                          // ♦ "Follow" Button:
                                          FollowButton(
                                            text: 'Follow',
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            borderColor: Colors.blue,
                                            function: () {},
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // ♦ "User Name":
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),

                        // ♦ Username:
                        child: Text(
                          // ♦ Getting "username" from "Database":
                          userData['username'],

                          // ♦ Style:
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // ♦ "Biography":
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 1,
                        ),
                        child: Text(
                          // ♦ Getting "bio" from "Database":
                          userData['bio'],
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),

                // ♦ "Posts":
                FutureBuilder(
                  // ♦ Getting "Posts" Collection → from "Database":
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),

                  builder: (context, snapshot) {
                    // ♦ Checking:
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // ♦ Displaying the "Circular Progress Indicator":
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // ♦ otherwise we Display "GridView.builder()":
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:

                      // ♦ "Grid Layouts"
                      //    → with a "Fixed Number" of "Tiles"
                      //    → in the "Cross Axis":
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        // ♦ Getting all "Data" from "Dayabase":
                        DocumentSnapshot snap =
                        (snapshot.data! as dynamic).docs[index];

                        // ♦ Displaying "Post Url":
                        return Image(
                          image: NetworkImage(snap['postUrl']),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
  }
}
