import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/styles/alert_dialog.dart';

class FirebaseExceptionHandler {
  BuildContext context;
  ErrorDialog errorDialog = ErrorDialog();
  FirebaseExceptionHandler(this.context);
  // FirebaseExceptionHandler.setError(this.errorDialog);

  alertDialogshowerOnFirebaseException(String errorCode) {
    switch (errorCode) {
      case 'wrong-password':
        errorDialog.returnAlertDialogOnError(
            context, "Email or Password Incorrect");
        break;

      case 'unknown':
        errorDialog.returnAlertDialogOnError(
            context, "Please Fill The Fields Correctly");
        break;

      case 'user-not-found':
        errorDialog.returnAlertDialogOnError(
            context, "Email or Password Incorrect");
        break;
      case 'email-already-in-use':
        // log("Custom: The email is already used");
        // Code to handle the error
        errorDialog.returnAlertDialogOnError(
            context, 'The email address is already in use by another account');
        // FocusScope.of(context).requestFocus(_focusNode);
        break;

      case 'invalid-email':
        errorDialog.returnAlertDialogOnError(
            context, "Enter a valid email address");
        break;
      case 'weak-password':
        break;
    }
  }
}
