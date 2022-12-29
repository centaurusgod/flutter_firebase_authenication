import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/modules/user_object.dart';

class SignUpServices {
 UserObject aSignleUserObject = UserObject();

  String email;
  String password;
  SignUpServices(this.email, this.password);
  
  //SignUpServices.login

  User? currentUser = FirebaseAuth.instance.currentUser;
  //  FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
//         'userId': currentUser!.uid,
//         'defaultAge': 20,
//         'defaultPhone': 0123456789,
//       });
  signUpUser(BuildContext context) async {
    try {
      FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
        'userId': currentUser!.uid,
        'defaultAge': 20,
        'defaultPhone': 0123456789,
        'createdDateTime':DateTime.now(),
      }).then((value) => {
        FirebaseAuth.instance.signOut(),
         Navigator.of(context)
                            .popUntil((route) => route.isFirst),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage.getEmail(email)),
                        ),

      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
