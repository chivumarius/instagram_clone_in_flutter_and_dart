import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

// ♦ The "AuthMethods" Class:
class AuthMethods {
  // ♦♦ Creating the "Instance" of "FirebaseFirestore" Class:
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ♦♦ Creating the "Instance" of "FirebaseAuth" Class:
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ♦♦ The "signUpUser" Async Function:
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    // ♦♦ Variable:
    String res = "Some error Occurred";

    // ♦♦ The "Try - Catch" Block:
    try {
      // ♦♦ Creating "Validation"
      //   → by "Checking" the "Condition" → "isNotEmpty":
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // ♦♦ "Registering" the "User" in "Auth"
        //     → with "Email" and "Password":
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // ♦ Checking if "StorageMethods()" Method "Run":
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // ♦ Adding "User" in our "Database":
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'followings': [],
          'photoUrl': photoUrl,
        });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }

      // ♦♦ To "Add" More "Error Details":
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == 'invalid-email') {
      //     res = 'The email is badly formatted.';
      //   } else if (err.code == 'weak-password') {
      //     res = 'Password should be at least 6 characters.';
      //   }

    } catch (err) {
      // ♦ Error Catching:
      return err.toString();
    }

    // ♦ Returning the "Response":
    return res;
  }
}
