import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/add_post_screen.dart';
import 'package:instagram_flutter/screens/feed_screen.dart';
import 'package:instagram_flutter/screens/search_screen.dart';

const webScreenSize = 600;

// ♦ The "List" of "Screens":
List<Widget> homeScreenItems = const [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('Notifications'),
  Text('Profile Screen'),
];
