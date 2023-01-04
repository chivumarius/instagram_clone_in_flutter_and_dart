import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variable.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
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
    // ♦ Setting:
    setState(() {
      _page = page;
    });
  }

  // ♦ The "navigationTapped()" Method:
  void navigationTapped(int page) {
    // ♦ Animating Page
    pageController.jumpToPage(page);

    // ♦ Setting:
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // ♦ APP BAR:
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [

          // ♦ "Home" Icon Button:
          IconButton(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(0),
          ),

          // ♦ "Search" Icon Button:
          IconButton(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(1),
          ),

          // ♦ "Add Photo" Icon Button:
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(2),
          ),

          // ♦ "Like" Icon Button:
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(3),
          ),

          // ♦ "Person" Icon Button:
          IconButton(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            onPressed: () => navigationTapped(4),
          ),
        ],
      ),

      // ♦ APP BODY:
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
    );
  }
}
