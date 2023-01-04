
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:instagram_flutter/models/user.dart' as model;

// ♦ The "AuthMethods" Class:
class AuthMethods {
  // ♦♦ Creating the "Instance" of "FirebaseFirestore" Class:
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ♦♦ Creating the "Instance" of "FirebaseAuth" Class:
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ♦♦ The "getUserDetails()" Method:
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // ♦♦ The "signUpUser" Async Function
  //    → with the "Required Parameters" for "Sign Up User":
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
      //   → by the "Condition" → "isNotEmpty":
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

        // ♦♦ We are creating a "New User"
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // ♦ Adding "User" in our "Database"
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

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

  // ♦♦ The "loginUser" Async Function
  //    → with the "Required Parameters" for "Log In User":
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    // ♦♦ Variable:
    String res = "Some error Occurred";

    // ♦♦ The "Try - Catch" Block:
    try {
      // ♦♦ Creating "Validation"
      //   → by the "Condition" → "isNotEmpty":
      if (email.isNotEmpty || password.isNotEmpty) {
        // ♦♦ "Sign In" the "User" in "Auth"
        //     → with "Email" and "Password":
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }

      // ♦♦ To "Add" More "Error Details":
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == 'user-not-found') {
      //     res = 'The user does not exist.';
      //   } else if (err.code == 'wrong-password') {
      //     res = 'The password is wrong.';
      //   }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // ♦♦ The "signOut()" Async Function:
  Future<void> signOut() async {
    await _auth.signOut();
  }

}