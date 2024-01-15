import 'package:flutter/material.dart';
import 'package:registration/resources/color_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // padding: EdgeInsets.zero,
        children: [
          MyDrawerHeader(),
          MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: Icons.home,
            index: 0,
            title: AppStrings.home,
          ),
          MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: Icons.favorite_border,
            index: 1,
            title: AppStrings.favorites,
          ),
          MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: Icons.play_arrow_outlined,
            index: 2,
            title: AppStrings.recentlyViewed,
          ),
          MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: Icons.settings,
            index: 3,
            title: AppStrings.setting,
          ),
          MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: Icons.info_outline_rounded,
            index: 4,
            title: AppStrings.aboutUs,
          ),
          MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: Icons.help,
            index: 5,
            title: AppStrings.help,
          ),
          MyDrawerItem(
            selectedIndex: selectedIndex,
            icon: Icons.logout,
            index: 6,
            title: AppStrings.signOut,
          ),
        ],
      ),
    );
  }
}
