import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:registration/generated/l10n.dart';
import 'package:registration/pages/forget_password/forget_password_screen.dart';
import 'package:registration/providers/update_profile_provider.dart';
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

  void openForgetPasswordScreen(BuildContext context) {
    // providerDispose();
    NavigationUtils.push(context: context, page: ForgetPasswordScreen());
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
        Provider.of<UpdateProfileProvider>(context, listen: false)
            .getUserPhotoUrl();
        Provider.of<UpdateProfileProvider>(context, listen: false)
            .getUserName();
        OverlayToastMessage.show(
            widget: OverlayCustomToast(
          message: S.of(context).YouLogedinSuccessfully,
          status: ToastMessageStatus.success,
        ));
        // providerDispose();
        OverlayLoadingProgress.stop();
        NavigationUtils.pushReplacement(context: context, page: DrawerScreen());
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      OverlayToastMessage.show(
        widget: OverlayCustomToast(
          message: ErrorHandler.getErrorMsg(e.code),
          status: ToastMessageStatus.failed,
        ),
      );
      OverlayLoadingProgress.stop();
    } catch (e) {
      print(e);
      OverlayToastMessage.show(
          widget: OverlayCustomToast(
        message: "General error: $e",
        status: ToastMessageStatus.failed,
      ));
      OverlayLoadingProgress.stop();
    }
  }
}
