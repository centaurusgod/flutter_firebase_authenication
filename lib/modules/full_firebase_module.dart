import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_auth/main.dart';
import 'package:flutter_firebase_auth/modules/firebase_exception_handler.dart';
import 'package:flutter_firebase_auth/modules/user_object.dart';
import 'package:flutter_firebase_auth/screens/note_list.dart';

import '../screens/home_page.dart';

class FirebaseManager {
//User ?user;
  final _user = FirebaseAuth.instance.currentUser ?? null;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//this buildcontext has no use more than to pass again in a different class
//and show alert dialog on various exceptions

  FirebaseManager.getUserObjectData(this.context, this.mainUserObject);
  FirebaseManager(this.context);
  UserObject mainUserObject = UserObject();
  BuildContext context;

  loginHandler() async {
    try {
      final User? firebaseUser = (await _auth.signInWithEmailAndPassword(
              email: mainUserObject.email, password: mainUserObject.password))
          .user;
      if (firebaseUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoteList(firebaseUser.uid)),
        );
        //send userID to UI
        //UI(firebaseUser.uid)
        //send string or boolean
      } else {
        //  returnAlertDialogOnError(context, "");
        //return email or password is incorrect
        //send string or boolean
      }
    } on FirebaseAuthException catch (error) {
      handleAllFirebaseAuthExceptions(error);
    }
  }

  Future signUpHandler() async {
    log("before user created");

    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: mainUserObject.email, password: mainUserObject.password)
          .then((value) => {
                log("user created"),
                loginHandler(),

                // .then((value) => {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => NoteList(user!.uid)),
                //           ),
                //         }),
              });

      try {
        _firebaseFirestore.collection("users").doc(_user!.uid).set({
          'userId': _user!.uid,
          'defaultAge': 20,
          'defaultPhone': 0123456789,
          'createdDateTime': DateTime.now(),
        }).then((value) => {
              _auth.signOut(),
            });
      } on FirebaseAuthException catch (error) {
        handleAllFirebaseAuthExceptions(error);
      }

      log("User Created");
    } on FirebaseAuthException catch (error) {
      handleAllFirebaseAuthExceptions(error);
    }
  }

  Future signOutHandler() async {
    try {
      await _auth.signOut().then((value) => {
            log("signed out"),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ),
          });
    } on FirebaseAuthException catch (error) {
      log("exception occured");
      handleAllFirebaseAuthExceptions(error);
    }
  }

  Future forgetPasswordHandler() async {}

//passes the error /exceptions as strings to the object
//which will print a alertdialog
  handleAllFirebaseAuthExceptions(Object error) async {
    FirebaseExceptionHandler exceptionHandler =
        FirebaseExceptionHandler(context);
    if (error is FirebaseAuthException) {
      exceptionHandler
          .alertDialogshowerOnFirebaseException(error.code.toString());
    }
  }

  // bool verifyEmailAddress(){
  //   FirebaseAuth.instance.sendSignInLinkToEmail(email:  mainUserObject.email, actionCodeSettings: actionCodeSettings)
  // }

}
