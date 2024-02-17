import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/setting_provider.dart';
import '../../resources/assets_manager.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key, this.backbtn = false});

  bool backbtn;

  @override
  Widget build(BuildContext context) {
    String local =
        Provider.of<SettingProvider>(context, listen: false).getLocal();
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          backbtn ? Navigator.pop(context) : ZoomDrawer.of(context)!.toggle();
        },
        icon: backbtn
            ? Icon(Icons.arrow_back)
            : (local == "ar")
                ? Image.asset(
                    ImageAssets.menuArIcon,
                    color: Colors.black,
                    fit: BoxFit.cover,
                    width: 15,
                    height: 15,
                  )
                : Image.asset(
                    ImageAssets.menuIcon,
                    color: Colors.black,
                    fit: BoxFit.cover,
                    width: 15,
                    height: 15,
                  ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
