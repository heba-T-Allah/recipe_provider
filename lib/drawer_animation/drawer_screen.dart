import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:registration/drawer_animation/menu_screen.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:registration/view/home/home_screen.dart';

import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/values_manager.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final ZoomDrawerController zoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar( actions: [
      //   Padding(
      //     padding: const EdgeInsets.symmetric(
      //         horizontal: AppConstants.horizontalPadding),
      //     child: Image.asset(
      //       ImageAssets.notificationsIcon,
      //       color: Colors.black,
      //       width: AppSize.s20,
      //       height: AppSize.s20,
      //     ),
      //   )
      // ],),
      backgroundColor: ColorManager.backgroundGreyColor,
      body: ZoomDrawer(
        controller: zoomController,
        menuScreen: MenuScreen(),
        mainScreen: HomeScreen(),
        clipMainScreen: false,
        slideWidth: MediaQuery
            .of(context)
            .size
            .width* 0.90,
        borderRadius: 24.0,
        // angle: -30.0,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      // showShadow: true,
      ),
    );
  }
}
