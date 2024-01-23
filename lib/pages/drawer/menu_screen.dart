import 'package:flutter/material.dart';
import 'package:registration/resources/color_manager.dart';

import '../../resources/strings_manager.dart';
import 'my_drawer_header.dart';
import 'my_drawer_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedIndex = 0;
  List<Map> drawerItems = [
    {'index': 0, 'icon': Icons.home, 'title': AppStrings.home},
    {
      'index': 1,
      'icon': Icons.food_bank_outlined,
      'title': AppStrings.ingredients
    },
    {'index': 2, 'icon': Icons.favorite_border, 'title': AppStrings.favorites},
    {
      'index': 3,
      'icon': Icons.play_arrow_outlined,
      'title': AppStrings.recentlyViewed
    },
    {'index': 4, 'icon': Icons.settings, 'title': AppStrings.setting},
    {
      'index': 5,
      'icon': Icons.info_outline_rounded,
      'title': AppStrings.aboutUs
    },
    {'index': 6, 'icon': Icons.help, 'title': AppStrings.help},
    {'index': 7, 'icon': Icons.logout, 'title': AppStrings.signOut},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.backgroundGreyColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // padding: EdgeInsets.zero,
            children: [
              MyDrawerHeader(),
              Column(
                children: drawerItems
                    .map(
                      (e) => MyDrawerItem(
                        selectedIndex: selectedIndex,
                        icon: e['icon'],
                        index: e['index'],
                        title: e['title'],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
