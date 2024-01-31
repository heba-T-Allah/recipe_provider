import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/pages/update_profile/update_profile_screen.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:registration/utils/navigation.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../app_bar/my_app_bar.dart';
import '../widgets/text_button_widget.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late String userName;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    userName =
        FirebaseAuth.instance.currentUser?.displayName.toString() ?? "No name";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MenuScreen(
        onPageSelected: (p0) {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p8, left: AppPadding.p30, right: AppPadding.p30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.setting, style: TextStyles.textStyleRegular26Black),
            const SizedBox(
              height: AppSize.s50,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorManager.backgroundGreyColor),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: ColorManager.textBlack,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          AppStrings.language,
                          style: TextStyles.textStyleMedium14Black,
                        )
                      ],
                    ),
                    Text(
                      AppStrings.english,
                      style: TextStyles.textStyleMedium14Orange,
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 40,
              color: ColorManager.greyText,
              thickness: 1,
            ),
            Text(AppStrings.profile, style: TextStyles.textStyleRegular26Black),
            const SizedBox(
              height: AppSize.s20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage("assets/images/1686.jpg"),
                    radius: AppSize.s60),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    userName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyles.textStyleRegular26Black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            TextButtonWidget(
                buttonText: AppStrings.updateProfile,
                textStyle: TextStyles.textStyleRegular16White,
                onPressed: () {
                  NavigationUtils.push(
                      context: context, page: UpdateProfileScreen());
                }),
          ],
        ),
      ),
    );
  }
}
