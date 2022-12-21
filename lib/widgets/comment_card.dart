import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          // ♦ Profile Image:
          const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1619539465730-fea9ebf950f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGUlMjBpbWFnZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
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
                    text: const TextSpan(
                      children: [
                        // ♦ "User Name":
                        TextSpan(
                            text: 'username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),

                        // ♦ The "Text" for the "Comment":
                        TextSpan(
                          text: 'Some description to insert',
                        ),
                      ],
                    ),
                  ),

                  // ♦ "Publication Date":
                  const Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '30/12/2022',
                      style: TextStyle(
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
