import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/about/about_screen.dart';
import 'package:registration/pages/favorite/favourite_screen.dart';
import 'package:registration/pages/home/home_screen.dart';
import 'package:registration/pages/ingredients/ingredients_screen.dart';
import 'package:registration/pages/settings/settings_screen.dart';
import 'package:registration/resources/color_manager.dart';
import '../../resources/text_style.dart';
import '../recently_viewed/recently_viewed_screen.dart';
import '../../providers/signup_provider.dart';
import 'my_drawer_header.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key, required this.onPageSelected, required this.context});

  final Function(Widget, int) onPageSelected;
  BuildContext context;
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedIndex = 0;

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
    List<Map> drawerItems = [
      {
        'index': 0,
        'icon': Icons.home,
        'title': S.of(context).home,
        'page': HomeScreen()
      },
      {
        'index': 1,
        'icon': Icons.food_bank_outlined,
        'title': S.of(context).ingredients,
        'page': IngredientsScreen()
      },
      {
        'index': 2,
        'icon': Icons.favorite_border,
        'title': S.of(context).favorites,
        'page': FavoriteScreen()
      },
      {
        'index': 3,
        'icon': Icons.play_arrow_outlined,
        'title': S.of(context).recentlyViewed,
        'page': RecentlyViewedScreen()
      },
      {
        'index': 4,
        'icon': Icons.settings,
        'title': S.of(context).setting,
        'page': SettingsScreen()
      },
      {
        'index': 5,
        'icon': Icons.info_outline_rounded,
        'title': S.of(context).aboutUs,
        'page': AboutScreen()
      },
      {'index': 6, 'icon': Icons.logout, 'title': S.of(context).signOut},
    ];
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
                              widget.onPageSelected(e['page'], selectedIndex);
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
