import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:registration/view/drawer/drawer_screen.dart';
import 'package:registration/view/sign_up/signup_screen.dart';
import '../../../utils/navigation.dart';

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
    passwordController?.dispose();
    emailController?.dispose();
    // formKey=null;
  }

  void openSignUpScreen(BuildContext context) {
    providerDispose();
    NavigationUtils.pushReplacement(context: context, page: SignUpScreen());
  }

  Future<void> login(BuildContext context) async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) =>Center(child: CircularProgressIndicator(),),
    // );
    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);
        print("login Successfully. $credentials ");
        // providerDispose();
        NavigationUtils.pushReplacement(context: context, page: DrawerScreen());
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    // Navigator.pop(context);
    // navigatorkey.currentstate!.popuntil((route) = route.isfirst);}

}
}
