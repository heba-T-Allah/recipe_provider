import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/pages/update_profile/update_profile_screen.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:registration/resources/strings_manager.dart';
import 'package:registration/utils/navigation.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../providers/update_profile_provider.dart';
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
    Provider.of<UpdateProfileProvider>(context,listen: false).getUserPhotoUrl();

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
      body: SingleChildScrollView(
        child: Padding(
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
                          const SizedBox(
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
                  CachedNetworkImage(
                    imageUrl: Provider.of<UpdateProfileProvider>(context,listen: false).profileImageUrl! ,
                    placeholder: (context, url) =>
                    new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: NetworkImage(
                          Provider.of<UpdateProfileProvider>(context,listen: false).profileImageUrl!,
                        ),
                        radius: AppSize.s40),
                  ),

                  const SizedBox(
                    width: AppSize.s20,
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
                        context: context, page: const UpdateProfileScreen());

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
