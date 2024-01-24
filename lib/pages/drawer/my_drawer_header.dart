import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../../resources/strings_manager.dart';
import '../../resources/text_style.dart';
import '../../resources/values_manager.dart';
import '../../utils/toast_msg_status.dart';
import '../widgets/overlay_custom_toast.dart';

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({
    super.key,
  });

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    String userName =
        FirebaseAuth.instance.currentUser?.displayName.toString() ?? "No name";
    var imageUrl="gs://recipe-app-6ad17.appspot.com/373697722_843580807125672_4441472092080271988_n.jpg";
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                OverlayLoadingProgress.start();
                var imageResult = await FilePicker.platform
                    .pickFiles(type: FileType.image, withData: true);
                var reference = FirebaseStorage.instance
                    .ref("user/${imageResult?.files.first.name}");
                if (imageResult?.files.first.bytes != null) {
                  var uploadResult = await reference.putData(
                      imageResult!.files.first.bytes!,
                      SettableMetadata(contentType: "image/png"));
                  if (uploadResult.state == TaskState.success) {
                    OverlayToastMessage.show(
                        widget: OverlayCustomToast(
                          message: "Image Uploaded successfully",
                          status: ToastMessageStatus.success,
                        ));
                     imageUrl=await reference.getDownloadURL();
                     setState(() {

                     });
                    print(
                        "-----------upload successfully${await reference.getDownloadURL()}");
                  }
                  else{
                    OverlayToastMessage.show(
                        widget: OverlayCustomToast(
                          message: "Something went wrong, please try again.",
                          status: ToastMessageStatus.failed,
                        ));
                  }
                }
                OverlayLoadingProgress.stop();
              },
              // child: CachedNetworkImage(
              //   imageUrl: imageUrl,
              //   placeholder: (context, url) =>
              //   new CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              //   imageBuilder: (context, image) => CircleAvatar(
              //       backgroundImage: NetworkImage(
              //         imageUrl,
              //       ),
              //       radius: AppSize.s40),
              // ),

             child:  CircleAvatar(
                  backgroundImage: AssetImage("assets/images/1686.jpg"),
                  radius: AppSize.s40),
            ),
            // SizedBox(width: 10,),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles.textStyleRegular18Black,
                    ),
                    Text(
                      AppStrings.viewProfile,
                      style: TextStyles.textStyleRegular10Grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
