import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:registration/providers/update_profile_provider.dart';

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
          String defaultProfileImage="https://firebasestorage.googleapis.com/v0/b/recipe-app-6ad17.appspot.com/o/user%2Ficon.png?alt=media&token=4f9b092d-8895-4386-9130-d425defcf3c1";
          sendEmailVerification();
          Provider.of<UpdateProfileProvider>(context,listen: false).updateProfileImage(defaultProfileImage);
          NavigationUtils.pushReplacement(
              context: context, page: SignInScreen());
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
  void sendEmailVerification() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      user.sendEmailVerification().then((_) {
        print("Email verification sent successfully!");
      }).catchError((error) {
        print("Failed to send email verification: $error");
      });
    } else {
      print("User is either not signed in or email is already verified.");
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
