import 'package:flutter/material.dart';
import 'package:registration/resources/color_manager.dart';

import '../view/drawer/my_drawer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.backgroundGreyColor,
        body: MyDrawer());
  }
}