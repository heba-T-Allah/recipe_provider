import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../resources/assets_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/values_manager.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key, this.backbtn = false});

  bool backbtn;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          backbtn ? Navigator.pop(context) : ZoomDrawer.of(context)!.toggle();
        },
        icon: backbtn
            ? Icon(Icons.arrow_back)
            : Image.asset(
                ImageAssets.menuIcon,
                color: Colors.black,
                fit: BoxFit.cover,
                width: 15,
                height: 15,
              ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding),
          child: Image.asset(
            ImageAssets.notificationsIcon,
            color: Colors.black,
            width: AppSize.s20,
            height: AppSize.s20,
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
