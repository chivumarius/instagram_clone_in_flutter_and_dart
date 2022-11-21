import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

// ♦♦ The "main()" Function:
void main() {
  runApp(const MyApp());
}

// ♦♦ The "MyApp" Class:
class MyApp extends StatelessWidget {
  // ♦♦ The Class "Cnstructor:"
  const MyApp({super.key});

  // ♦♦ This "build" Method of the Class:
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const Scaffold(body: Text('Lets build Instagram!')),
    );
  }
}
