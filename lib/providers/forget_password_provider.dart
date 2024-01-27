import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:registration/utils/toast_msg_status.dart';

import '../networking/handling_error_firebase.dart';
import '../pages/widgets/overlay_custom_toast.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  TextEditingController? emailController;
  GlobalKey<FormState>? formKey;

  void init() {
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  void providerDispose() {
    emailController = null;
    formKey = null;
  }



  Future<void> forgetPassword(BuildContext context) async {
    OverlayLoadingProgress.start();

    try {
      if (formKey?.currentState?.validate() ?? false) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email:  emailController!.text,);

        OverlayToastMessage.show(
            widget: OverlayCustomToast(
              message: "Mail send Successfully",status: ToastMessageStatus.success,
            ));
        OverlayLoadingProgress.stop();
        // providerDispose();
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      OverlayToastMessage.show(
        widget: OverlayCustomToast(
          message: ErrorHandler.getErrorMsg(e.code),status: ToastMessageStatus.failed,
        ),
      );
      OverlayLoadingProgress.stop();
    } catch (e) {
      print(e);
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
            message: "General error: $e",status: ToastMessageStatus.failed,
          ));
      OverlayLoadingProgress.stop();
    }
  }
}
