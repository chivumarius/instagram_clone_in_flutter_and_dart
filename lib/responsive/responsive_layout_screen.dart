import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/utils/dimensions.dart';
import 'package:provider/provider.dart';

// ♦♦ The "ResponsiveLayout" StatelessWidget:
class ResponsiveLayout extends StatefulWidget {
  // ♦ Variables:
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  // ♦♦ The Class "Constructor":
  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  // ♦♦ The "initState()" Method:
  @override
  void initState() {
    super.initState();
    addData();
  }

  // ♦♦ The "addData()" Method:
  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  // ♦♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ♦ Responsive Screen Layout:
        if (constraints.maxWidth > webScreenSize) {
          // ♦ Displaying the "Web Screen":
          return widget.webScreenLayout;
        }
        // ♦ Displaying the "Mobile Screen":
        return widget.mobileScreenLayout;
      },
    );
  }
}
