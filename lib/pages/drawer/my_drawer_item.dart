import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/ingredients/ingredients_screen.dart';
import '../../resources/color_manager.dart';
import '../../resources/text_style.dart';
import '../../utils/navigation.dart';
import '../about/about_screen.dart';
import '../favorite/favourite_screen.dart';
import '../help/help_screen.dart';
import '../home/home_screen.dart';
import '../recently_viewed/recently_viewed_screen.dart';
import '../settings/settings_screen.dart';
import '../sign_up/logic/signup_provider.dart';

class MyDrawerItem extends StatefulWidget {
  MyDrawerItem(
      {super.key,
      required this.selectedIndex,
      required this.index,
      required this.title,
      required this.icon});

  int selectedIndex;
  final int index;
  final String title;
  final IconData icon;

  @override
  State<MyDrawerItem> createState() => _MyDrawerItemState();
}

class _MyDrawerItemState extends State<MyDrawerItem> {
  TextStyle? drawerTextStyle(int index) {
    return (widget.selectedIndex == index)
        ? TextStyles.textStyleMedium14Orange
        : TextStyles.textStyleMedium14Grey;
  }

  Color? drawerIconColor(int index) {
    return (widget.selectedIndex == index)
        ? ColorManager.primaryColor
        : ColorManager.greyText;
  }

  onItemTapped(int index) async {
    setState(() {
      widget.selectedIndex = index;
    });
    switch (index) {
      case 0:
        return NavigationUtils.pushReplacement(
            context: context, page: HomeScreen());
      case 1:
        return NavigationUtils.pushReplacement(
            context: context, page: IngredientsScreen());
      case 2:
        return NavigationUtils.pushReplacement(
            context: context, page: FavoriteScreen());
      case 3:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: RecentlyViewedScreen());
      case 4:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: SettingScreen());
      case 5:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: AboutScreen());
      case 6:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: HelpScreen());
      case 7:
        Provider.of<SignUpProvider>(context, listen: false).signOut(context);
      default:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, color: drawerIconColor(widget.index)),
      title: Text(widget.title, style: drawerTextStyle(widget.index)),
      selected: widget.selectedIndex == widget.index,
      onTap: () {
        // Update the state of the app
        onItemTapped(widget.index);
        print(widget.selectedIndex);
        // Navigator.pop(context);
      },
    );
  }
}
