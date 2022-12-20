import 'package:cloud_firestore/cloud_firestore.dart';

// ♦ Uploading the User in Firebase
//   → by Creating the "User" Model:
class User {
  // ♦ Properties:
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  // ♦♦ Constructor:
  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  // ♦♦ The "fromSnap()" Method
  //     → which will Take a "DocumentSnapshot"
  //     → that it will "Convert" into a "User Model":
  static User fromSnap(DocumentSnapshot snap) {
    // ♦ Getting "data()" and Marked "as Map<>":
    var snapshot = snap.data() as Map<String, dynamic>;

    // ♦♦ Returning an "User Model":
    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  // ♦♦ The "toJson()" Method
  //     → for "Converting Data" to an "Object" ("Map"):
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
