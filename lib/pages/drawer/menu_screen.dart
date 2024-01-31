import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/about/about_screen.dart';
import 'package:registration/pages/favorite/favourite_screen.dart';
import 'package:registration/pages/home/home_screen.dart';
import 'package:registration/pages/ingredients/ingredients_screen.dart';
import 'package:registration/pages/settings/settings_screen.dart';
import 'package:registration/resources/color_manager.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../recently_viewed/recently_viewed_screen.dart';
import '../../providers/signup_provider.dart';
import 'my_drawer_header.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key, required this.onPageSelected});

  final Function(Widget) onPageSelected;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedIndex = 0;
  List<Map> drawerItems = [
    {
      'index': 0,
      'icon': Icons.home,
      'title': AppStrings.home,
      'page': HomeScreen()
    },
    {
      'index': 1,
      'icon': Icons.food_bank_outlined,
      'title': AppStrings.ingredients,
      'page': IngredientsScreen()
    },
    {
      'index': 2,
      'icon': Icons.favorite_border,
      'title': AppStrings.favorites,
      'page': FavoriteScreen()
    },
    {
      'index': 3,
      'icon': Icons.play_arrow_outlined,
      'title': AppStrings.recentlyViewed,
      'page': RecentlyViewedScreen()
    },
    {
      'index': 4,
      'icon': Icons.settings,
      'title': AppStrings.setting,
      'page': SettingsScreen()
    },
    {
      'index': 5,
      'icon': Icons.info_outline_rounded,
      'title': AppStrings.aboutUs,
      'page': AboutScreen()
    },

    {'index': 6, 'icon': Icons.logout, 'title': AppStrings.signOut},
  ];

  TextStyle? drawerTextStyle(int index) {
    return (selectedIndex == index)
        ? TextStyles.textStyleMedium14Orange
        : TextStyles.textStyleMedium14Grey;
  }

  Color? drawerIconColor(int index) {
    return (selectedIndex == index)
        ? ColorManager.primaryColor
        : ColorManager.greyText;
  }

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
                    .map((e) => ListTile(
                          leading: Icon(e['icon'],
                              color: drawerIconColor(e['index'])),
                          title: Text(e['title'],
                              style: drawerTextStyle(e['index'])),
                          selected: selectedIndex == e['index'],
                          onTap: () {
                            selectedIndex = e['index'];
                            if (selectedIndex == 6) {
                              Provider.of<SignUpProvider>(context,
                                      listen: false)
                                  .signOut(context);
                            } else {
                              widget.onPageSelected(e['page']);
                            }
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
