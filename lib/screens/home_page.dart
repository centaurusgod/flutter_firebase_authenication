import 'package:flutter/material.dart';
import 'sign_up.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  Icon passwordVisibility = Icon(Icons.visibility);
  Icon passwordHide = Icon(Icons.visibility_off);
  @override
  Widget build(BuildContext context) {
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
                      onPressed: (() {}),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
