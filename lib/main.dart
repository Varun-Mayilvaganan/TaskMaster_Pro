import 'package:flutter/material.dart';
import 'package:todo_firebase/auth/authscreen.dart';
//import 'package:todo_firebase/screens/homepage.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
      theme:
          ThemeData(brightness: Brightness.light, primaryColor: Colors.purple),

    );
  }
}