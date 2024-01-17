import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:registration/view/home/home_screen.dart';

import 'menu_screen.dart';



class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final ZoomDrawerController zoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: zoomController,
        menuScreen: MenuScreen(),
        mainScreen: HomeScreen(),
        clipMainScreen: true,

        slideWidth: MediaQuery
            .of(context)
            .size
            .width* 0.90,
        borderRadius: 24.0,
        // angle: -30.0,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      // showShadow: true,
        menuBackgroundColor: ColorManager.backgroundGreyColor,

    );
  }
}
