abstract class ErrorHandler {
  //error handling codes
  static const invalidCredentialCode = "invalid-credential";
  static const emailalreadyInUseCode = "email-already-in-use";
  static const invalidEmailCode = "invalid-email";
  static const operationNotAllowedCode = "operation-not-allowed";
  static const weakPasswordCode = "weak-password";
  static const wrongPasswordCode = "wrong-password";
  static const userDisabledCode = "user-disabled";
  static const userNotFoundCode = "user-not-found";

  //Error msgs
  static const invalidCredentialMsg = "These credential is not valid.";
  static const invalidEmailMsg = "The email address is not valid.";
  static const wrongPasswordMsg = "The password is invalid for the given email";
  static const userDisabledMsg = "The given email has been disabled.";
  static const userNotFoundMsg =
      " There is no user corresponding to the given email.";
  static const emailalreadyInUseMsg =
      "There is already exists an account with the given email address.";
  static const operationNotAllowedMsg =
      "The email/password accounts are not enabled. ";
  static const weakPasswordMsg = "The password is not strong enough.";

  static String getErrorMsg(String code) {
    switch (code) {
      case emailalreadyInUseCode:
        return emailalreadyInUseMsg;
      case invalidEmailCode:
        return invalidEmailMsg;
      case operationNotAllowedCode:
        return operationNotAllowedMsg;
      case weakPasswordCode:
        return weakPasswordMsg;
      case wrongPasswordCode:
        return wrongPasswordMsg;
      case userDisabledCode:
        return userDisabledMsg;
      case userNotFoundCode:
        return userNotFoundMsg;
      case invalidCredentialCode:
        return invalidCredentialMsg;
      default:
        return code;
    }
  }
}
