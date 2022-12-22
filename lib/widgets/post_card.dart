import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart' as model;
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/screens/comments_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  // ♦ Property:
  final snap;

  // ♦ Constructor
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // ♦ Variable:
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    // ♦ Getting the "User":
    final model.User? user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // ♦♦ "Header Section" of the "Post":
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                // ♦ Profile Image:
                CircleAvatar(
                  radius: 16,

                  // ♦ "Grab" the "Profile Image" from "DB":
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'].toString(),
                  ),
                ),

                // ♦ Username:
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          // ♦ "Grab" the "Username" from "DB":
                          widget.snap['username'].toString(),

                          // ♦ Text Style :
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ♦ Icon Button:
                IconButton(
                  onPressed: () {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                      onTap: () {},
                                    ),
                                  )
                                  .toList()),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
          ),

          // ♦♦ "Image Section" of the "Post:"
          GestureDetector(
            // ♦ Detecting "Double Tap" on "Image":
            onDoubleTap: () {
              // ♦ Calling the "likePost()" Function:
              FireStoreMethods().likePost(
                // ♦ "Grab" the "Post Id" from "Database":
                widget.snap['postId'].toString(),
                user!.uid,

                // ♦ "Grab" the "Likes" from "Database":
                widget.snap['likes'],
              );

              // ♦ Enable:
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,

              // ♦ List:
              children: [
                // ♦ "Image":
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    // ♦ "Grab" the "Image" from "Database":
                    widget.snap['postUrl'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),

                // ♦ Animation "Like Icon" on the "Image":
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,

                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      // ♦ Setting:
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },

                    // ♦ The "Like" Icon on the "Image":
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ♦♦ "Like & Comment Section" of the "Post":
          Row(
            children: <Widget>[
              // ♦ "Like Animation":
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user?.uid),

                // ♦ Enable "Like":
                smallLike: true,

                child: IconButton(
                  // ♦ Conditional Rendering
                  //    → for the "Color" of the "Like Icon":
                  icon: widget.snap['likes'].contains(user?.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),

                  // ♦ Calling the "likePost()" Function:
                  onPressed: () => FireStoreMethods().likePost(
                    // ♦ "Grab" the "Post Id" from "Database":
                    widget.snap['postId'].toString(),
                    user!.uid,

                    // ♦ "Grab" the "Likes" from "Database":
                    widget.snap['likes'],
                  ),
                ),
              ),

              // ♦ "Comment Outlined" Icon Button:
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                ),

                // ♦ Redirecting to the "CommentsScreen()":
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
              ),

              // ♦ "Send" Icon Button:
              IconButton(
                icon: const Icon(
                  Icons.send,
                ),
                onPressed: () {},
              ),

              // ♦ "Bookmark" Icon:
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),

          // ♦♦ "Description" and "Number of Comments":
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      // ♦ "Grab" the "Number" of "Likes" from "Database":
                      '${widget.snap['likes'].length} likes',

                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),

                  // ♦ "Username" & "Description":
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        // ♦ Username:
                        TextSpan(
                          // ♦ "Grab" the "Username" from "Database":
                          text: widget.snap['username'].toString(),

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // ♦ Description:
                        TextSpan(
                          // ♦ "Grab" the "Description" from "Database":
                          text: '${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),

                // ♦ "Number" of "Comments":
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: const Text(
                      'View all 22 comments',

                      // ♦ Text Style:
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),

                // ♦ "Publication Date":
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    // ♦ "Grab" the "Publication Date" from "Database"
                    //    → by Using "intl" Package:
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),

                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
