import 'package:flutter/material.dart';

// ♦♦ The "TextFieldInput" Class:
class TextFieldInput extends StatelessWidget {
  // ♦♦ Properties:
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  // ♦♦ The "Constructor":
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ♦♦ Property
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    // The "TextField()" Widget:
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
