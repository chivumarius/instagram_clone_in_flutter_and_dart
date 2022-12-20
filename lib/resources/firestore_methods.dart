import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class FireStoreMethods {
  // ♦ Creating Instances of the Class:
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ♦ The "uploadPost()" Method:
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      // ♦ "Upload Image" → To "Storage":
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      // ♦ Getting the "Post ID"
      //    → By using "Uuid" Package:
      String postId = const Uuid().v1(); // creates unique id based on time

      // ♦ Creating a "Post":
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
