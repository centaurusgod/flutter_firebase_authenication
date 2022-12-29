import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../styles/gradient_text.dart';
import 'home_page.dart';
import 'note_keep.dart';

class NoteList extends StatefulWidget {
  String userID = "";
  NoteList(this.userID);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState.setUserID(userID);
  }
}

class NoteListState extends State<NoteList> {
  String userID = "";
  NoteListState();

  NoteListState.setUserID(this.userID);

  //TextEditingController noteController = TextEditingController();
  List<String> notes = List.empty(growable: true);
  Stream<QuerySnapshot>? snapshotStream;
 // Stream<QuerySnapshot>? stream;
  @override
  void initState() {
    super.initState();
   // notes = List.empty(growable: true);
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    //getNotes();
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
                       // Navigator.of(context).pop(),
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                      });
                } on FirebaseAuthException catch (error) {
                  returnAlertDialogOnError(context, "$error");
                }
              }),
              child: Text("Sign Out")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.of(context).pop();
          //getNotes();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteKeep()),
          );
          setState(() {
           // getNotes();
          });
        },
        backgroundColor: Color.fromARGB(255, 57, 0, 74),
        child: Icon(Icons.add),
      ),
       body:
       StreamBuilder<QuerySnapshot>(
        stream: snapshotStream,
        builder: (context, snapshot){
          if(snapshot.hasData){
             //  List<DocumentSnapshot> documents = snapshot.data.documents;
             log("list working");
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index){
 return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(notes[index]),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                	//_delete(context, noteList[position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              	//navigateToDetail(this.noteList[position]);
            },
          ),
        );
});
          }
          else{
             return Center(child: CircularProgressIndicator());
          }
        },
       )
    
    );
    //  body:getNoteListView(),
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

  Future getNotes() async {
    log(userID);
    Map<String, dynamic> dataMap;
    notes=List.empty(growable: true);
    
    log("getting notes");
    try {
      snapshotStream = FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .collection("notes")
          .snapshots();

          snapshotStream!.listen(
            (snapshot){
            for(var note in snapshot.docs){
              log("no error");
              dataMap = note.data() as Map<String, dynamic>;
              log(dataMap.toString());
             createListOfNotes(dataMap);
            }
          });

      log("after firebase");
     // log(snapshotStream.toString());

    } catch (error) {
      log("Error occured");
      log(error.toString());
    }
    //print(dataMap);
    log("Function comlete");
  //  log(notes.toString());
  }

  void createListOfNotes(Map<String, dynamic> map) {
   notes.add(map['Note']);
   print(notes);
  }

}
