import 'package:flutter/material.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/resources/color_manager.dart';

import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: MyAppBar(),
        drawer: MenuScreen(
          context: context,
          onPageSelected: (p0, p1) {
            
          },
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                top: AppPadding.p8,
                left: AppPadding.p30,
                right: AppPadding.p30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).aboutUs,
                    style: TextStyles.textStyleRegular26Black),
                const SizedBox(
                  height: AppSize.s50,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorManager.backgroundGreyColor),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Flexible(
                      child: Text(
                        S.of(context).aboutUsContent,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: TextStyles.textStyleMedium16Black,
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
