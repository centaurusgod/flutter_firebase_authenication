import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/sign_up.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home is "screens/home_page.dart"
    home: HomePage(),
    routes: {
      '/sign_up_screen': (context)=>SignUpPage(),
    },
  ));
}
