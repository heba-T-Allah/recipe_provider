import 'package:flutter/material.dart';
import 'package:registration/resources/strings_manager.dart';
import 'my_drawer_header.dart';
import 'my_drawer_item.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int selectedIndex = 0;
  List<Map> drawerItems = [
    {'index': 0, 'icon': Icons.home, 'title': AppStrings.home},
    {'index': 1, 'icon': Icons.favorite_border, 'title': AppStrings.favorites},
    {'index': 2, 'icon': Icons.play_arrow_outlined, 'title': AppStrings.recentlyViewed},
    {'index': 3, 'icon': Icons.settings, 'title': AppStrings.setting},
    {'index': 4, 'icon': Icons.info_outline_rounded, 'title': AppStrings.aboutUs},
    {'index': 5, 'icon': Icons.help, 'title': AppStrings.help},
    {'index': 6, 'icon': Icons.logout, 'title': AppStrings.signOut},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // padding: EdgeInsets.zero,
        children: [
          MyDrawerHeader(),
          Column(children: drawerItems.map((e) => MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: e['icon'],
            index: e['index'],
            title: e['title'],
          ),).toList(),),

        ],
      ),
    );
  }
}
