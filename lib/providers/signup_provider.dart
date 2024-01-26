import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../networking/handling_error_firebase.dart';
import '../utils/navigation.dart';
import '../utils/toast_msg_status.dart';
import '../pages/drawer/drawer_screen.dart';
import '../pages/on_boarding/on_boarding_screen.dart';
import '../pages/sign_in/signin_screen.dart';
import '../pages/widgets/overlay_custom_toast.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController? fullNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  GlobalKey<FormState>? formKey;

  void init() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  void providerDispose() {
    passwordController = null;
    emailController = null;
    fullNameController = null;
    formKey = null;
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();

        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);
        if (credentials.user != null) {
          await credentials.user?.updateDisplayName(fullNameController!.text);
          providerDispose();
          OverlayToastMessage.show(
              widget: OverlayCustomToast(
                message: "You register Successfully",status: ToastMessageStatus.success,
              ));
          print("signUp Successfully. $credentials ");
          NavigationUtils.pushReplacement(
              context: context, page: DrawerScreen());
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
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

  void openSigninScreen(BuildContext context) {
    // providerDispose();
    NavigationUtils.pushReplacement(context: context, page: SignInScreen());
  }

  void signOut(BuildContext context) {
    try {
      OverlayLoadingProgress.start();
      FirebaseAuth.instance.signOut().then((value) =>
          NavigationUtils.pushAndRemoveUntil(
              context: context, page: OnBoardingScreen()));
      OverlayLoadingProgress.stop();
    } catch (e) {
      print(e);
      OverlayLoadingProgress.stop();
    }
  }
}
