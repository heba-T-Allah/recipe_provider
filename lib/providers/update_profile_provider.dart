import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:registration/utils/toast_msg_status.dart';
import '../pages/widgets/overlay_custom_toast.dart';

class UpdateProfileProvider extends ChangeNotifier {
  TextEditingController? nameController;


  void init() {
    nameController = TextEditingController();

  }

  void providerDispose() {
    nameController = null;
  }


String getUserName(){
  String userName =
      FirebaseAuth.instance.currentUser?.displayName.toString() ?? "No name";

  return userName;
}
  Future<void> updateUserName(BuildContext context) async {
    OverlayLoadingProgress.start();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Update the display name
        user.updateDisplayName(nameController!.text.toString()).then((_) {
          getUserName();

          OverlayToastMessage.show(
                    widget: OverlayCustomToast(
                      message: "Name updated successfully!",status: ToastMessageStatus.success,
                    ));
          OverlayLoadingProgress.stop();

        }).catchError((error) {
          OverlayToastMessage.show(
            widget: OverlayCustomToast(
              message: "Failed to update name.",status: ToastMessageStatus.failed,
            ),
          );
          OverlayLoadingProgress.stop();
        });
        Navigator.of(context).pop();
      }

  }
}
