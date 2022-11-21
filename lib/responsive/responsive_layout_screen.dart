import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/dimensions.dart';

// ♦♦ The "ResponsiveLayout" StatelessWidget:
class ResponsiveLayout extends StatelessWidget {
  // ♦ Variables:
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  // ♦♦ The Class "Constructor":
  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  // ♦♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ♦ Responsive Screen Layout:
        if (constraints.maxWidth > webScreenSize) {
          // ♦ Displaying the "Web Screen":
          return webScreenLayout;
        }
        // ♦ Displaying the "Mobile Screen":
        return mobileScreenLayout;
      },
    );
  }
}
