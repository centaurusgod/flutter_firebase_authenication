import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'note_keep.dart';
import 'sign_up.dart';

class HomePage extends StatefulWidget {
  String email="";
  HomePage();
  HomePage.getEmail(this.email);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState(email);
  }
}

class _HomePageState extends State<HomePage> {
 var emailFirst;
  _HomePageState(this.emailFirst);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  Icon passwordVisibility = Icon(Icons.visibility);
  Icon passwordHide = Icon(Icons.visibility_off);
 @override 
 void initState(){
emailFirst="";
emailController.text="";
  super.initState();
 }
  @override
  Widget build(BuildContext context) {
    //emailController.text = email;
    // /passwordVisibility = Icon(Icons.visibility);
    // passwordVisibility;
    //hidePassword;
    return Scaffold(
      //appBar: AppBar(),
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 20.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  cursorColor: Colors.white,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 176, 176, 176)),
                  ),
                ),
                TextField(
                  obscureText: hidePassword,
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: passwordVisibility,
                      color: Colors.white,
                      onPressed: () {
                        // code to be executed when the icon is tapped

                        setState(() {
                          //  passwordVisibility = Icon(Icons.visibility_off);
                          hidePassword = !hidePassword;
                          passwordVisibility = hidePassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off);
                        });
                        //  print("icon tapped");
                      },
                    ),
                    hintText: "Password",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 176, 176, 176)),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        //  minimumSize: Size.fromHeight(15),
                        // maximumSize:  Size.fromHeight(20),
                        backgroundColor: Color.fromARGB(255, 0, 141, 188),
                      ),
                      onPressed: (() async {
                        var email = emailController.text;
                        var password = passwordController.text;
                        try {
                          final User? firebaseUser = (await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password))
                              .user;
                          if (firebaseUser != null) {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteKeep.setUserID(
                                      firebaseUser.uid.toString())),
                            );
                          } else {
                            returnAlertDialogOnError(
                                "Incorrect Email Or Password");
                          }
                        } catch (e) {
                          log(e.toString());
                          if (e is FirebaseAuthException) {
                            // log(error.code);
                            switch (e.code.toString()) {
                              case 'wrong-password': returnAlertDialogOnError(
                                "Incorrect Email Or Password");
                                break;
                                case 'unknown': returnAlertDialogOnError("Please Fill Out the ffields correctly"); break;
                                case 'user-not-found': returnAlertDialogOnError(
                                "Incorrect Email Or Password");
                                break;
                            }
                          }
                        }
                      }),
                      icon: Icon(Icons.lock_open),
                      label: Text("Sign In"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "OR",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 32, 151, 2),
                        //  minimumSize: Size.fromHeight(15),
                        // maximumSize:  Size.fromHeight(20),
                      ),
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      }),
                      icon: Icon(Icons.lock),
                      label: Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  returnAlertDialogOnError(String textValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(textValue),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
