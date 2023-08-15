import 'package:flutter/material.dart';
import 'package:todo_firebase/auth/authform.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 58, 31, 141),
        
        title: Text("Authentication",),
      ),
      body: AuthForm(),
    );
  }
}