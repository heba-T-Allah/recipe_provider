import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:registration/resources/color_manager.dart';
import '../home/home_screen.dart';
import 'menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late ZoomDrawerController zoomController;

  Widget page = HomeScreen();

  @override
  void initState() {
    zoomController = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreenTapClose: true,
      disableDragGesture: true,
      controller: zoomController,
      menuScreen: MenuScreen(
        onPageSelected: (p) {
          setState(() {
            page = p;
            zoomController.close?.call();
          });
        },
      ),
      mainScreen: page,
      clipMainScreen: true,
      shadowLayer1Color: ColorManager.backgroundGreyColor,
      // slideWidth: MediaQuery.of(context).size.width * 0.70,
      borderRadius: 24.0,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      showShadow: true,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      menuBackgroundColor: ColorManager.backgroundGreyColor,
    );
  }
}
