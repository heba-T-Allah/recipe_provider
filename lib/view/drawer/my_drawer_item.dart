import 'package:flutter/material.dart';
import 'package:registration/view/about/about_screen.dart';
import 'package:registration/view/favorite/favourite_screen.dart';
import 'package:registration/view/recently_viewed/recently_viewed_screen.dart';
import 'package:registration/view/settings/settings_screen.dart';
import '../../resources/color_manager.dart';
import '../../resources/text_style.dart';
import '../../utils/navigation.dart';
import '../costom/shared_functions.dart';
import '../help/help_screen.dart';
import '../home/home_screen.dart';

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

  onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
    switch (index) {
      case 0:
        return NavigationUtils.pushReplacement(
            context: context, page: HomeScreen());
      case 1:
        return NavigationUtils.pushReplacement(
            context: context, page: FavoriteScreen());
      case 2:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: RecentlyViewedScreen());
      case 3:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: SettingScreen());
      case 4:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: AboutScreen());
      case 5:
        return NavigationUtils.pushAndRemoveUntil(
            context: context, page: HelpScreen());
      case 6:
        final sharedFunctions = SharedFunctions(context: context);
        return sharedFunctions.logoutUser();
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
