import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../styles/gradient_text.dart';
import 'home_page.dart';

class NoteKeep extends StatelessWidget {
  String? userID;
  NoteKeep();

  NoteKeep.setUserID(this.userID);

  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 0, 41),
        title: newGradientText("Keep Your Notes"),
        actions: [
          ElevatedButton(
              onPressed: (() async {
                try {
                  await FirebaseAuth.instance.signOut().then((value) => {
                        returnAlertDialogOnError(
                            context, "signed Out Sucessfully"),
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst),
                        Navigator.of(context).pop(),
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                      });
                } on FirebaseAuthException catch (error) {}
              }),
              child: Text("Sign Out")),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 50.0, right: 50.0),
        child: Column(
          children: [
            Text("Hello $userID"),
            TextField(
              style: TextStyle(color: Color.fromARGB(255, 55, 0, 82)),
              controller: noteController,
              cursorColor: Color.fromARGB(255, 0, 0, 0),
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                hintText: "Memo",
                hintStyle: TextStyle(color: Color.fromARGB(255, 176, 176, 176)),
              ),
            ),
            ElevatedButton(
                onPressed: (() async {
                  try {
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(userID).collection("notes").add({
                          'Remainder':noteController.text,
                          'Created Date':DateTime.now(),
                        }).then((value) => {
                          noteController.text="",
                        });

                    // await FirebaseFirestore.instance.collection("notes").add({
                    //   "content": noteController.text.trim(),
                    //   "timestamp": DateTime.now(),
                    // });
                  } on FirebaseAuthException catch (error) {
                    print(error);
                  }
                }),
                child: Icon(Icons.add))
          ],
        ),
      ),
    );
  }

  returnAlertDialogOnError(BuildContext context, String textValue) {
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

  GradientText newGradientText(String text) {
    return GradientText(
      text,
      style: const TextStyle(fontSize: 30),
      gradient: LinearGradient(colors: [
        Color.fromARGB(255, 255, 4, 4),
        Color.fromARGB(255, 255, 153, 0),
        Color.fromARGB(255, 217, 255, 0),
        Color.fromARGB(255, 4, 255, 0),
        Colors.indigo,
        Color.fromARGB(255, 224, 4, 248),
      ]),
    );
  }
}
