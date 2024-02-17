import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/providers/setting_provider.dart';
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
  int currentPageIndex = 0;
  bool willPop = false;

  @override
  void initState() {
    zoomController = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, value, child) {
      String local = value.getLocal();
      return ZoomDrawer(
        mainScreenTapClose: true,
        disableDragGesture: true,
        controller: zoomController,
        menuScreen: MenuScreen(
          context: context,
          onPageSelected: (p, i) {
            setState(() {
              page = p;
              currentPageIndex = i;
              zoomController.close?.call();
            });
          },
        ),
        mainScreen: PopScope(
            canPop:
                willPop, //When false, blocks the current route from being popped.
            onPopInvoked: (didPop) {
              setState(() {});
              willPop = false;
              if (currentPageIndex == 0) {
                willPop = true;
                setState(() {});

                showExitDialog(context);
              } else {
                page = HomeScreen();
                currentPageIndex = 0;
                willPop = false;
                setState(() {});
              }
            },
            child: page),
        clipMainScreen: true,
        shadowLayer1Color: ColorManager.backgroundGreyColor,
        // slideWidth: MediaQuery.of(context).size.width * 0.70,
        isRtl: (local == "ar") ? true : false,
        borderRadius: 24.0,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
        showShadow: true,
        drawerShadowsBackgroundColor: Colors.grey.shade300,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        menuBackgroundColor: ColorManager.backgroundGreyColor,
      );
    });
  }

  Future<dynamic> showExitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctxt) => AlertDialog(
              title: Text(S.of(context).ExitApp),
              content: Text(S.of(context).Areyousureyouwanttoexit),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    willPop = false;
                    Navigator.of(context).pop(false);
                  },
                  child: Text(S.of(context).No),
                ),
                TextButton(
                  onPressed: () {
                    willPop = true;
                    return Navigator.of(context).pop(true);
                  },
                  child: Text(S.of(context).Yes),
                ),
              ],
            ));
  }
}
