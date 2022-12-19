import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ♦♦ The "pickImage()" Function
//     → For "Picking Up Image" from "Gallery":
pickImage(ImageSource source) async {
  // ♦♦ Creating the "Instance" of "ImagePicker" Class:
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  // ♦♦ Checking:
  if (_file != null) {
    return await _file.readAsBytes();
  }
  // ♦ Otherwise:
  debugPrint('No Image Selected');
}

// ♦♦ The "showSnackBar()" Function
//     → For Displaying "SnackBars":
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
