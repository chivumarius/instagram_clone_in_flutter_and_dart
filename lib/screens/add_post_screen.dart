import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  // ♦ Constructor:
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ♦ "App Bar":
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          'Post to',
        ),
        centerTitle: false,
        actions: <Widget>[
          // ♦ The "Post" Button:
          TextButton(
            onPressed: () {},
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),

      // ♦ The "Post Form":
      body: Column(
        // ♦ Widgets "List":
        children: <Widget>[
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,

            // ♦ Widgets "List":
            children: <Widget>[
              // ♦ User "Image":
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/id/499728904/photo/unknown-person-silhouette.jpg?b=1&s=170667a&w=0&k=20&c=UOwAKxscCf2MyB9RiEtz36Mq5Ln7GvJUpfL0e5a512Y=',
                ),
              ),

              // ♦ "Caption" → "Text Field":
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: "Write a caption...", border: InputBorder.none),
                  maxLines: 8,
                ),
              ),

              // ♦ The "Image Loaded" on the "Right":
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1576405515541-cb47b7da4fa7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fE1PQklMRSUyMEJBQ0tHUk9VTkR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
