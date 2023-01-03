import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {

  // ♦ Constructor:
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
    return Scaffold(

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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [

                          // ♦ Profile Photo:
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/id/619400810/photo/mr-who.jpg?b=1&s=170667a&w=0&k=20&c=-gmePfcINJC_YpZE_b-6cq6go6MgS9OBhcXhKdmOFKI=',
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
                                    buildStatColumn(20, "posts"),
                                    buildStatColumn(150, "followers"),
                                    buildStatColumn(10, "following"),
                                  ],
                                ),

                                // ♦ Buttons:
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                   FollowButton(
                                            text: 'Edit Profile',
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            textColor: primaryColor,
                                            borderColor: Colors.grey,
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
                        child: const Text(
                          'username',
                          style: TextStyle(
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
                        child: const Text(
                          'bio',
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),

              ],
            ),
          );
  }
}
