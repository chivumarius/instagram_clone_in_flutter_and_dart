import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid.dart';

class StorageMethods {
  // ♦♦ Creating the "Instance" of "FirebaseAuth" Class:
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ♦♦ Creating the "Instance" of "FirebaseStorage" Class:
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ♦♦ The "uploadImageToStorage" Method
  //    → Adding "Image" to "Firebase Storage":
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // ♦♦ The ".ref()" Method
    //    → is a "Pointer" ti the "File" in our "Firebase/ Storage"
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // ♦♦ Checking: If the "Image" is "Uploaded" to "Storage":
    if (isPost) {
      // ♦ Creating a "Unique ID":
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // ♦♦ Adding a "File" → in this "Location":
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;

    // ♦♦ Getting the "Image Url" from the "Storage":
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
