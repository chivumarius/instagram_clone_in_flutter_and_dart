import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

// ♦♦ The "Dynamic Class":
class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // ♦ Variable:
  int _page = 0;

  // ♦ Controller:
  late PageController pageController; // for tabs animation

  // ♦ The "nitState()" Method:
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  // ♦ The "dispose()" Method:
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // ♦ The "onPageChanged()" Method:
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  // ♦ The "navigationTapped()" Method:
  void navigationTapped(int page) {
    // ♦ Animating Page
    pageController.jumpToPage(page);
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Text('Feed Screen'),
          Text('Search Screen'),
          Text('Add Post Screen'),
          Text('Notification Screen'),
          Text('Profile Screen'),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: (_page == 3) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 4) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        currentIndex: _page,
      ),
    );
  }
}
