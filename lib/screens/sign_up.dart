import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  Icon passwordVisibility = Icon(Icons.visibility);
  Icon passwordHide = Icon(Icons.visibility_off);
  bool _isChecked = false;
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
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  decoration: InputDecoration(
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
                    Text(
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
                  onPressed: (() {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SignUpPage(),
                    //   ),
                    // );
                    String value = "";
                    value = emailController.text.toString();
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alert'),
                            content: Text('Please Enter a Valid EMail Address.'),
                            actions: [
                              ElevatedButton(
                                child: Text('OK'),
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
}
