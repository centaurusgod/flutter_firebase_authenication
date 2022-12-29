import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/modules/user_object.dart';
import 'package:flutter_firebase_auth/screens/home_page.dart';

import '../modules/full_firebase_module.dart';
import '../services/signup_services.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  SignUpServices? newSignUpHandler;

  bool hidePassword = true;
  Icon passwordVisibility = Icon(Icons.visibility);
  Icon passwordHide = Icon(Icons.visibility_off);
  bool _isChecked = false;
  FocusNode _focusNode = FocusNode();
  // User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  focusNode: _focusNode,
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  textDirection: TextDirection.ltr,
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
                    hintText: "Password",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 176, 176, 176)),
                  ),
                ),
                TextField(
                  obscureText: hidePassword,
                  style: TextStyle(color: Colors.white),
                  controller: confirmPasswordController,
                  cursorColor: Colors.white,
                  textDirection: TextDirection.ltr,
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 176, 176, 176)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: ((value) {
                        _isChecked = !_isChecked;
                        hidePassword = !hidePassword;
                        setState(() {});
                      }),
                      checkColor: Colors.amber,
                      activeColor: Colors.black,
                    ),
                    const Text(
                      "Show Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 32, 151, 2),
                    //  minimumSize: Size.fromHeight(15),
                    // maximumSize:  Size.fromHeight(20),
                  ),
                  onPressed: (() async {
                    //checkForNullInstances();
                    String email = emailController.text.toString();
                    returnAlertDialogOnEmailError(
                        email, "Please Enter Valid Email");
                    // testCaseSignUp();
                    if (_validatePassword()) {
                      UserObject mainUserObject = UserObject.signUp(
                          emailController.text.trim(), passwordController.text);
                      FirebaseManager newInstance =
                          FirebaseManager.getUserObjectData(
                              context, mainUserObject);
                      newInstance.signUpHandler();
                      //doe to implement signUp

                      log("after firebase");
                    }

                    setState(() {});
                  }),
                  icon: Icon(Icons.lock),
                  label: Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//created this to check email at first by mistake
//so just didnt remove the code instead added a new lambda function
//to show alertdialoges
  returnAlertDialogOnEmailError(String value, String textValue) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text(textValue),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // return 'Please enter a valid email address';
    }
    return null;
  }

  //showing alert dialog for various kind of error
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

//function to validate password
//and meet criteria for a strong password
//matching length etc
  bool _validatePassword() {
    // Minimum length
    String password = passwordController.text.toString();
    if (password.length < 8) {
      returnAlertDialogOnError("Password must be at least 8 characters");
      return false;
    }
    if (passwordController.text.toString() !=
        confirmPasswordController.text.toString()) {
      returnAlertDialogOnError("Password didnot match");
      return false;
    }

    // Must contain at least one lowercase letter, one uppercase letter, one digit, and one special character
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password)) {
      returnAlertDialogOnError(
          "Use symbol, character, number, uppercase, lowercase in your password");
      return false;
    }

    // Cannot contain the username
    // Replace this with your own logic to check for the username
    if (password.contains(emailController.text.toString())) {
      returnAlertDialogOnError("Password cannot be Email");
      return false;
    }

    // Passwords that are too common are not allowed
    // Replace this with your own logic to check for common passwords
    if (['password', '123456', 'qwerty'].contains(password)) {
      returnAlertDialogOnError("Very weak password");
      return false;
    }

    return true;
  }

//test case for auto implementation an d tetsing
  testCaseSignUp() {
    emailController.text = "ozonewagle998@gmail.com";
    passwordController.text = "Show6999!";
    confirmPasswordController.text = "Show6999!";
    log(emailController.text);
    //   createUser();
  }
}
