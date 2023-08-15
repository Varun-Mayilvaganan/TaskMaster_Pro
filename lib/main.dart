import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/auth/authscreen.dart';
import 'package:todo_firebase/screens/homepage.dart';
//import 'package:todo_firebase/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, usersnapshot)
      {
        if (usersnapshot.hasData)
        {
          return Home();
        }
        else{
          return AuthScreen();
        }
      },
      ),
      theme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.purple),

    );
  }
}