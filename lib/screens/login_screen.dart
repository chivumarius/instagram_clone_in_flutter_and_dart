import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
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

  // ♦ The "Loading Indicator" Variable:
  //   → Set to "False":
  bool _isLoading = false;

  // ♦♦ The "dispose()" Method
  //    → which "Releases" the "Memory Allocated"
  //    → to the Existing "Variables" of the "State":
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // ♦♦ The "loginUser()" Method:
  void loginUser() async {
    // ♦♦ Setting the "Loading Indicator" to "True":
    setState(() {
      _isLoading = true;
    });

    // ♦♦ The "res" Variable
    //     → to "Log In User" using our "AuthMethods":
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // ♦♦ Checking: If "String Returned" is "Success"
    //    → then "User" can be "Log In":
    if (res == 'success') {
      // ♦♦ Avoiding "Do Not Use BuildContexts Across Async Gaps" Error:
      if (!mounted) return;

      // ♦♦ "Redirecting" the "User",
      //    → to the "LoginScreen"
      //    → after Clicking the "Login" Link:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // ♦♦ Avoiding "Do Not Use BuildContexts Across Async Gaps" Error:
      if (!mounted) return;

      // ♦♦ Showing the Error:
      showSnackBar(context, res);
    }
  }

  // ♦♦ The "navigateToSignup()" Method:
  void navigateToSignup() {
    // ♦♦ "Redirecting" the "User",
    //    → to the "SignupScreen"
    //    → after Clicking the "Signup" Link:
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
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
                onTap: loginUser,
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

                  // ♦♦ The "Ternary Operator"
                  //      → for "Checking" the "_isLoading" Variable
                  //      → and "Displaying" the "Button Text"
                  //     → or the "Loading Indicator":
                  child: !_isLoading
                      ?
                      // ♦ The "Log In" Text Display:
                      const Text(
                          'Log in',
                        )
                      :
                      // ♦ The "CircularProgressIndicator()" Widget Display:
                      const CircularProgressIndicator(
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
                      'Don`t have an account?',
                    ),
                  ),

                  // ♦ The "Signup" Link
                  //   → through the "GestureDetector()" Widget
                  //   → that Detects Gestures:
                  GestureDetector(
                    onTap: navigateToSignup,

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
