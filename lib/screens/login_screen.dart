import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ♦ Private Properties:
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ♦♦ The "dispose()" Method
  //    → which "Releases" the "Memory Allocated"
  //    → to the Existing "Variables" of the "State":
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
              const SizedBox(
                height: 64,
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
                  child: const Text('Log in'),
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
                      'Don`t have an account?',
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
                        ' Signup.',
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
