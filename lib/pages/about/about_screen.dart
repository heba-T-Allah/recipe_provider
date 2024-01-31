
import 'package:flutter/material.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:registration/resources/strings_manager.dart';

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
          onPageSelected: (p0) {},
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p30,
                  right: AppPadding.p30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.aboutUs,
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
                          "this Recipe app is for people who are confused about choosing meals, as it allows them to add the ingredients available in their kitchen and choose the appropriate meal for them. they can also view the meals they have recently viewed, add meals to favorites, and remove them.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style: TextStyles.textStyleMedium16Black,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
