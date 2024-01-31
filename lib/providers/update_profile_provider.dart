import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    getUserPhotoUrl();
    getUserName();
  }

  void providerDispose() {
    nameController = null;
  }

  String getUserName() {
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
        notifyListeners();
        getUserName();

        OverlayToastMessage.show(
            widget: OverlayCustomToast(
          message: "Name updated successfully!",
          status: ToastMessageStatus.success,
        ));
        OverlayLoadingProgress.stop();
      }).catchError((error) {
        OverlayToastMessage.show(
          widget: OverlayCustomToast(
            message: "Failed to update name.",
            status: ToastMessageStatus.failed,
          ),
        );
        OverlayLoadingProgress.stop();
      });
      Navigator.of(context).pop();
    }
  }

  String? _profileImageUrl;

  String? get profileImageUrl => _profileImageUrl;

  set profileImageUrl(String? value) {
    _profileImageUrl = value;
  }

  void getUserPhotoUrl() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.photoURL != null) {
      String photoUrl = user.photoURL!;
      profileImageUrl = user.photoURL!;
      print("User photo URL: $photoUrl");
    } else {
      print("User photo URL is not available.");
    }
  }

  void uploadProfileImage() async {
    OverlayLoadingProgress.start();
    var imageResult = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    var reference =
        FirebaseStorage.instance.ref("user/${imageResult?.files.first.name}");
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
        profileImageUrl = await reference.getDownloadURL();
        notifyListeners();
        print(
            "-----------upload successfully${await reference.getDownloadURL()}");
        updateProfileImage(profileImageUrl!);
      } else {
        OverlayToastMessage.show(
            widget: OverlayCustomToast(
          message: "Something went wrong, please try again.",
          status: ToastMessageStatus.failed,
        ));
      }
    }
    OverlayLoadingProgress.stop();
  }

  void updateProfileImage(String imageUrl) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      user.updatePhotoURL(imageUrl).then((_) {
        OverlayToastMessage.show(
            widget: OverlayCustomToast(
          message: "Profile image updated successfully!",
          status: ToastMessageStatus.success,
        ));
        getUserPhotoUrl();
        print("Profile image updated successfully!");
      }).catchError((error) {
        OverlayToastMessage.show(
          widget: OverlayCustomToast(
            message: "Failed to update profile image: $error",
            status: ToastMessageStatus.failed,
          ),
        );
        // print("Failed to update profile image: $error");
      });
    }
  }
}
