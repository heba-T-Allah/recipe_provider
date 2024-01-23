import 'package:flutter/material.dart';
import 'package:registration/pages/drawer/menu_screen.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../home/widgets/search_and_filter.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: MyAppBar(),
        drawer: MenuScreen(),
        body: Padding(
            padding: const EdgeInsets.only(
                top: AppPadding.p8,
                left: AppPadding.p20,
                right: AppPadding.p20),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                    height: AppSize.s20,
                    child: Text(
                      "Notifications",
                      style: TextStyles.textStyleRegular13Grey,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    AppStrings.whatWouldYouLikeToCook,
                    style: TextStyles.textStyleAbrilRegular20Black
                        .copyWith(height: 1.5),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  const SearchAndFilter(),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                ]))));
  }
}
