import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
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
                children: const [
                  // ♦♦ The "Circular Avatar" Widget
                  //     → to "Accept" and "Show"
                  //     → the "Selected File":
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1633113215988-4eaddc3965d9?ixlib=rb-1.2.16ixid=MnwxMjA3fDF8MH'),
                  ),

                  // ♦♦ The "Positioned()" Widget
                  //     → Control "Where" is "Positioned"
                  //     → a "Child" of a "Stack"
                  Positioned(
                    bottom: -10,
                    left: 80,

                    // ♦ The "IconButton()" Widget:
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.add_a_photo),
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
                  child: const Text('Sign up'),
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
