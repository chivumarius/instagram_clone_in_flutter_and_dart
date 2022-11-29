import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
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

      // ♦♦ Implementation of the "Persistent User State" Concept
      //     → via the "StreamBuilder()" Widget
      //     → Returned by "Firebase":
      home: StreamBuilder(
        // ♦♦ The ".authStateChanges()" Method
        //     → that is "Run" only when the "User Sign In"
        //     → and when the "User Sign Out":
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // ♦♦ Checking the "Establishment" of "Connection":
          if (snapshot.connectionState == ConnectionState.active) {
            // ♦♦ Checking: If the "Snapshot" has any "Data" or "Not":
            if (snapshot.hasData) {
              // ♦♦ If "Snapshot" has Data
              //     → which means "User" is "Logged In"
              //     → then we "Check" the width of "Screen" and Accordingly
              //     → "Display" the "Screen Layout":
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              // ♦♦ If the "Connection" was "Established"
              //    → but the "Snapshot" has "No Data",
              //    → but has an "Error":
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          // ♦♦ Means "Connection" to Future "has not been Made" yet:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              // ♦♦ Displaying the "Loading Indicator":
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          // ♦♦ Otherwise we "Return" the "Screen":
          return const LoginScreen();
        },
      ),
    );
  }
}
