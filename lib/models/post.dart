import 'package:cloud_firestore/cloud_firestore.dart';

// ♦ Uploading the "Post" in Firebase
//   → by Creating the "Post Model":
class Post {
  // ♦ Properties:
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  // ♦ Constructor:
  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  // ♦♦ The "fromSnap()" Method
  //     → which will Take a "DocumentSnapshot"
  //     → that it will "Convert" into a "Post Model":
  static Post fromSnap(DocumentSnapshot snap) {
    // ♦ Getting "data()" and Marked as "Map<>" ("Object"):
    var snapshot = snap.data() as Map<String, dynamic>;

    // ♦♦ Returning an "Post Model":
    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage']);
  }

  // ♦♦ The "toJson()" Method
  //     → for "Converting Data" to an "Object" ("Map"):
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}
