import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:instagram_flutter/models/user.dart';

class AddPostScreen extends StatefulWidget {
  // ♦ Constructor:
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // ♦ Variables:
  Uint8List? _file;
  bool isLoading = false;

  // ♦ Controller:
  final TextEditingController _descriptionController = TextEditingController();

  // ♦ The "_selectImage()" Method
  //    → to Return a "Dialog Box" with "3 Options":
  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            // ♦ Option 1 → "Take a Photo":
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),

            // ♦ Option 2 → "Choose from Gallery":
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),

            // ♦ Option 3 → "Cancel":
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  // ♦ the "postImage()" Method
  //   → for "Storing Data" in the "Database":
  void postImage(String uid, String username, String profImage) async {
    // ♦ Displaying the "Linear Loading Indicator"::
    setState(() {
      isLoading = true;
    });

    // ♦ Start the "Loading":
    try {
      // ♦ "Upload" to "Storage" and "DB":
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );

      // ♦ Informing the "User" that the "Image" has been "Posted":
      if (res == "success") {
        // ♦♦ Avoiding "Do Not Use BuildContexts Across Async Gaps" Error:
        if (!mounted) return;

        showSnackBar(
          context,
          'Posted!',
        );

        // ♦ Calling the Function:
        clearImage();
      } else {
        // ♦♦ Avoiding "Do Not Use BuildContexts Across Async Gaps" Error:
        if (!mounted) return;

        showSnackBar(context, res);
      }
    } catch (err) {
      // ♦ Disabling "Display" of the "Linear Loading Indicator":
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  // ♦ The "clearImage()" Method:
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  // ♦ The "dispose()" Method:
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    // ♦ Displaying the "User Profile":
    final User? user = Provider.of<UserProvider>(context).getUser;

    // ♦ Conditional Display
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload,
              ),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            // ♦ "App Bar":
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text(
                'Post to',
              ),
              centerTitle: false,
              actions: <Widget>[
                // ♦ The "Post" Button:
                TextButton(
                  // ♦ "Storing Data" in the "Database"
                  //   → by the "postImage()" Method:
                  onPressed: () => postImage(
                    user!.uid,
                    user.username,
                    user.photoUrl,
                  ),
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
                // ♦ Conditional "Display" of the "Linear Load Indicator:"
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // ♦ Widgets "List":
                  children: <Widget>[
                    // ♦ User "Image":
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user!.photoUrl,
                      ),
                    ),

                    // ♦ "Caption" → "Text Field":
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
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
