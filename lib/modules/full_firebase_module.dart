import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_auth/modules/firebase_exception_handler.dart';
import 'package:flutter_firebase_auth/modules/user_object.dart';

import '../screens/home_page.dart';

class FirebaseManager {
//User ?user;
  final user = FirebaseAuth.instance.currentUser;

//this buildcontext has no use more than to pass again in a different class
//and show alert dialog on various exceptions

  FirebaseManager.getUserObjectData(this.context, this.mainUserObject);
  FirebaseManager(this.context);
  UserObject mainUserObject = UserObject();
  BuildContext context;

  loginHandler() async {
    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: mainUserObject.email,
                  password: mainUserObject.password))
          .user;
      if (firebaseUser != null) {
        //send userID to UI
        //UI(firebaseUser.uid)
        //send string or boolean
      } else {
        // returnAlertDialogOnError(context, textValue)
        //return email or password is incorrect
        //send string or boolean
      }
    } on FirebaseAuthException catch (error) {
      handleAllFirebaseAuthExceptions(error);
    }
  }

  signUpHandler() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: "", password: "")
          .then((value) => {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(user!.uid)
                    .set({
                  'userId': user!.uid,
                  'defaultAge': 20,
                  'defaultPhone': 0123456789,
                  'createdDateTime': DateTime.now(),
                }),
              });

      log("User Created");
    } on FirebaseAuthException catch (error) {}
  }

  signOutHandler() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ),
          });
    } on FirebaseAuthException catch (error) {
      handleAllFirebaseAuthExceptions(error);
    }
  }

  forgetPasswordHandler() async {}

//passes the error /exceptions as strings to the object
//which will print a alertdialog
  handleAllFirebaseAuthExceptions(Object error) {
    FirebaseExceptionHandler exceptionHandler =
        FirebaseExceptionHandler(context);
    if (error is FirebaseAuthException) {
      exceptionHandler
          .alertDialogshowerOnFirebaseException(error.code.toString());
    }
  }
}
