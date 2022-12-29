import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/note_list.dart';
import 'screens/home_page.dart';
import 'screens/sign_up.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home is "screens/home_page.dart"
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _MyAppState();
  }

}
class _MyAppState extends State<MyApp>{
  User? user;
  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override 
  Widget build(BuildContext context){
    if(user!=null){
//print(user);
      return NoteList(user!.uid);
    }
   // print(user);
    return HomePage();
  }
}
