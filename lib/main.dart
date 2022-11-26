import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';

// ♦♦ The "main()" Function:
void main() async {
  // ♦ Ensure Initialization of Flutter Widgets:
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // ♦ Initialize the "Web Application":
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAt7oFJLa3gDUrJYTTE4JOmNUDx3Yd6YcU",
        appId: "1:1080167123309:web:0261ac2542c3fa7a9b3264",
        messagingSenderId: "1080167123309",
        projectId: "instagram-clone-9d2a8",
        storageBucket: "instagram-clone-9d2a8.apps pot.com",
      ),
    );
  } else {
    // ♦ Firebase Application Initialization:
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

// ♦♦ The "MyApp" Class:
class MyApp extends StatelessWidget {
  // ♦♦ The Class "Constructor:"
  const MyApp({super.key});

  // ♦♦ This "build" Method of the Class:
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),

      home: const SignupScreen(),
    );
  }
}
