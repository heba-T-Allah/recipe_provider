import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/drawer/menu_screen.dart';
import 'package:registration/pages/update_profile/update_profile_screen.dart';
import 'package:registration/providers/setting_provider.dart';
import 'package:registration/resources/color_manager.dart';
import 'package:registration/utils/navigation.dart';
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

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    Provider.of<UpdateProfileProvider>(context, listen: false)
        .getUserPhotoUrl();
  }

  @override
  Widget build(BuildContext context) {
    List<String> langList = <String>[
      S.of(context).english,
      S.of(context).arabic
    ];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: MenuScreen(
        context: context,
        onPageSelected: (p0, p1) {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: AppPadding.p8, left: AppPadding.p30, right: AppPadding.p30),
          child: Consumer<SettingProvider>(
              builder: (context, settingProvider, child) {
            String local = settingProvider.getLocal();
            String dropdownValue =
                (local == "ar") ? langList.last : langList.first;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).setting,
                    style: TextStyles.textStyleRegular26Black),
                const SizedBox(
                  height: AppSize.s50,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorManager.backgroundGreyColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                              S.of(context).language,
                              style: TextStyles.textStyleMedium14Black,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          child: DropdownButtonFormField<String>(
                            hint: (local == "ar")
                                ? Text(langList.last,
                                    style: TextStyles.textStyleMedium14Orange)
                                : Text(langList.first,
                                    style: TextStyles.textStyleMedium14Orange),
                            value: (local == "ar")
                                ? langList.last
                                : langList.first,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                settingProvider.setLocal(value);
                              });
                            },
                            items: langList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyles.textStyleMedium14Black,
                                  ));
                            }).toList(),
                          ),
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
                Text(S.of(context).profile,
                    style: TextStyles.textStyleRegular26Black),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Consumer<UpdateProfileProvider>(
                  builder: (BuildContext context, value, Widget? child) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: value.profileImageUrl!,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, image) => CircleAvatar(
                            backgroundImage: NetworkImage(
                              value.profileImageUrl!,
                            ),
                            radius: AppSize.s40),
                      ),
                      const SizedBox(
                        width: AppSize.s20,
                      ),
                      Flexible(
                        child: Text(
                          value.getUserName(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyles.textStyleRegular26Black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                TextButtonWidget(
                    buttonText: S.of(context).updateProfile,
                    textStyle: TextStyles.textStyleRegular16White,
                    onPressed: () {
                      NavigationUtils.push(
                          context: context, page: const UpdateProfileScreen());
                    }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
