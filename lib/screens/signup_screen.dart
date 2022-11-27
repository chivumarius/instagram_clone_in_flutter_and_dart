import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // ♦ Private Properties:
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  // ♦♦ The "dispose()" Method
  //    → which "Releases" the "Memory Allocated"
  //    → to the Existing "Variables" of the "State":
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  // ♦♦ The "selectImage()" Method
  //     → for Picking the User Image:
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    // ♦ We "Set State"
    //    → because we Need to "Display" the "Image"
    //   → we "Selected" on the "Circle Avatar":
    setState(() {
      _image = im;
    });
  }

  // ♦♦ The "selectImage()" Method
  void signUpUser() async {
    // ♦♦ Set "Loading" to "True":
    setState(() {
      _isLoading = true;
    });

    // ♦♦ "SignUp User" using our "AuthMethods":
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    // ♦♦ Set "Loading" to "False":
    setState(() {
      _isLoading = false;
    });

    // ♦♦ Checking: If "String Returned" is "Success"
    //    → and "User" has been "Created":
    if (res != "success") {
      // ♦♦ Show the Error:
      showSnackBar(context, res);
    }
  }

  // ♦♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ♦♦ Top Spacing:
              Flexible(
                flex: 2,
                child: Container(),
              ),

              // ♦♦ SVG Image:
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),

              // ♦♦ Spacing:
              const SizedBox(
                height: 24,
              ),

              // ♦♦ The "Stack()" Widget
              //     → which "Positions" its "Children"
              //     → Relative to the "Edges" of its "Box":
              Stack(
                children: [
                  // ♦♦ The "Ternary Conditional Operator":
                  _image != null

                      // ♦♦ The "Circular Avatar" Widget
                      //     → to "Accept" and "Show"
                      //     → the "Selected File":
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,

                          // ♦ Default Profile Image:
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),

                  // ♦♦ The "Positioned()" Widget
                  //     → Control "Where" is "Positioned"
                  //     → a "Child" of a "Stack"
                  Positioned(
                    bottom: -10,
                    left: 80,

                    // ♦ The "IconButton()" Widget:
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),

              // ♦♦ Spacing:
              const SizedBox(
                height: 24,
              ),

              // ♦♦ UserName - Text Field:
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),

              // ♦♦ Spacing:
              const SizedBox(
                height: 24,
              ),

              // ♦♦ Email - Text Field:
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),

              // ♦♦ Spacing:
              const SizedBox(
                height: 24,
              ),

              // ♦♦ Password - Text Field:
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),

              // ♦♦ Spacing:
              const SizedBox(
                height: 24,
              ),

              // ♦♦ Bio - Text Field:
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),

              // ♦♦ Spacing:
              const SizedBox(
                height: 24,
              ),

              // ♦♦ Login Button:
              // ♦♦ The "InkWell()" Widget
              //   → is a "Rectangular Area" of a "Material"
              //   → that "Responds" to "Touch".
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),

                  // ♦♦  Checking the "_isLoading":
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),

              // ♦♦ Spacing:
              const SizedBox(
                height: 12,
              ),

              // ♦♦ Bottom Spacing:
              Flexible(
                flex: 2,
                child: Container(),
              ),

              // ♦♦ Transitioning to Signing Up:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ♦♦ Adding the "Text":
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Already have an account?',
                    ),
                  ),

                  // ♦ The "Signup" Link
                  //   → through the "GestureDetector()" Widget
                  //   → that Detects Gestures:
                  GestureDetector(
                    onTap: () {},

                    // ♦♦ Sign Up:
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
