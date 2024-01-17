import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/navigation.dart';
import '../../drawer/drawer_screen.dart';
import '../../sign_in/signin_screen.dart';

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
    passwordController?.dispose();
    emailController?.dispose();
    fullNameController?.dispose();
    // formKey=null;
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);
        if (credentials.user != null) {
          credentials.user?.updateDisplayName(fullNameController!.text);
          // providerDispose();
          print("signUp Successfully. $credentials ");
          NavigationUtils.pushReplacement(
              context: context, page: DrawerScreen());
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void openSigninScreen(BuildContext context) {
    // providerDispose();
    NavigationUtils.pushReplacement(context: context, page: SignInScreen());
  }
}
