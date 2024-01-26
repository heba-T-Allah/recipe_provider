import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:registration/utils/toast_msg_status.dart';
import 'package:registration/pages/drawer/drawer_screen.dart';
import 'package:registration/pages/sign_up/signup_screen.dart';
import '../networking/handling_error_firebase.dart';
import '../utils/navigation.dart';
import '../pages/widgets/overlay_custom_toast.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  GlobalKey<FormState>? formKey;

  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  void providerDispose() {
    passwordController = null;
    emailController = null;
    formKey = null;
  }

  void openSignUpScreen(BuildContext context) {
    providerDispose();
    NavigationUtils.pushReplacement(context: context, page: SignUpScreen());
  }

  Future<void> login(BuildContext context) async {
    OverlayLoadingProgress.start();

    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);
        print("login Successfully. $credentials ");
        OverlayToastMessage.show(
            widget: OverlayCustomToast(
              message: "You login Successfully",status: ToastMessageStatus.success,
            ));
        providerDispose();
        OverlayLoadingProgress.stop();
        NavigationUtils.pushReplacement(context: context, page: DrawerScreen());
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
