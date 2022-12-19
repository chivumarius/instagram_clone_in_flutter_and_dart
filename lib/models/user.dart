import 'package:cloud_firestore/cloud_firestore.dart';

// ♦ The "Class" (Widget):
class User {
  // ♦ Properties:
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  // ♦ Constructor:
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
  //     → to Convert the Requested Arguments
  //     → into an JSON Object:
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
