import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/update_profile_provider.dart';
import 'package:registration/resources/color_manager.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../../utils/toast_msg_status.dart';
import '../widgets/overlay_custom_toast.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    Provider.of<UpdateProfileProvider>(context, listen: false).init();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p30),
          child: Consumer<UpdateProfileProvider>(
            builder: (context, value, child) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.updateProfile,
                          style: TextStyles.textStyleRegular26Black),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: Container(
                          height: 135,
                          width: 135,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(130),
                              color: Colors.black),
              
                          child: CachedNetworkImage(
                            imageUrl: Provider.of<UpdateProfileProvider>(context,listen: false).profileImageUrl!,
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: NetworkImage(
                                  Provider.of<UpdateProfileProvider>(context,listen: false).profileImageUrl!,
                                ),
                                radius: AppSize.s40),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(color: ColorManager.primaryColor),
                              color: ColorManager.backgroundGreyColor),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.photo_camera_rounded),
                              onPressed: (){
                                value.uploadProfileImage();
                              }
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: TextField(
                      controller: value.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.backgroundGreyColor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        hintText: value.getUserName(),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(AppStrings.userName),
                        ),
                        labelStyle: TextStyles.textStyleRegular14grey,
                        hintStyle: TextStyles.textStyleRegular14grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (value.nameController!.text.toString() == null ||
                                value.nameController!.text.toString().isEmpty) {
                              OverlayToastMessage.show(
                                widget: OverlayCustomToast(
                                  message: "Please enter your name.",
                                  status: ToastMessageStatus.failed,
                                ),
                              );
                            } else {
                              value.updateUserName(context);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorManager.primaryColor))
                          // Change the button's background color here
                          ,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppStrings.changeName,
                              style: TextStyles.textStyleRegular16White,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
