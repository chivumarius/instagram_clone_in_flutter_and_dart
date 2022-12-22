import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  // ♦ Property:
  final snap;

  // ♦ Constructor:
  const CommentCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          // ♦ Profile Image:
          CircleAvatar(
            backgroundImage: NetworkImage(
              // "Getting" and "Displaying" the "Profile Picture"
              //  → from the "Database":
              snap['profilePic'],
            ),
            radius: 18,
          ),

          // ♦ The "Text Entered" by the "User"
          //   → as a "Comment":
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ♦ "User Name" & "Text" for the "Comment"
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            // "Getting" and "Displaying" the "User Name"
                            //  → from the "Database":
                            text: snap['name'],

                            // ♦ Style:
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                          // "Getting" and "Displaying" the "Comment Text"
                          //  → from the "Database":
                          text: ' ${snap['text']}',
                        ),
                      ],
                    ),
                  ),

                  // ♦ "Publish Date":
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      // "Getting" and "Displaying" the "Publish Date"
                      //  → from the "Database":
                      DateFormat.yMMMd().format(
                        snap['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ♦ "Like" Icon:
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
