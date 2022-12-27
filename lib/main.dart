import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home is "screens/home_page.dart"
    home: HomePage(),
  ));
}
