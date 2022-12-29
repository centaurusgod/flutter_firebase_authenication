import 'dart:developer';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/note_list.dart';
import 'package:flutter_firebase_auth/styles/gradient_text.dart';

class NoteKeep extends StatelessWidget {
  String note="";
  NoteKeep.passNote(this.note);
  NoteKeep();
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    noteController.text= note;
    print(note);
    return Scaffold(
        appBar: AppBar(title: newGradientText("Add Notes")),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                controller: noteController,
              ),
              ElevatedButton(onPressed: () {
              addNotesToFirebase(context);


              }, child: Icon(Icons.add))
            ],
          ),
        ));
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

void addNotesToFirebase(BuildContext context)async{
  User ?user;
   user = FirebaseAuth.instance.currentUser;
try{
  FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("notes").add({
    'Note':noteController.text.trim(),
    "Created On":DateTime.now(),
  }).then((value) => {
    log("Sucessfully Added Note"),
    Navigator.of(context).pop(),
    //  Navigator.of(context).pop(),
     Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteList(user!.uid)),
          ),
  });

} on FirebaseAuthException catch(error){
  log(error.toString());
}

}

}
