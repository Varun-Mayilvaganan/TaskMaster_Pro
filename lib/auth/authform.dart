import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _username = '';
  var _email = '';
  var _password = '';
  bool isLoginPage = false;

  startauthentication() async {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    try {
      if (isLoginPage) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        final authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
        String uid = authResult.user!.uid;

        // Initialize Firestore (make sure you have done this in your main.dart)
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Use _username and _email instead of username and email
        await firestore.collection('users').doc(uid).set({
          'username': _username,
          'email': _email,
        });
      }
    } catch (err) {
      print(err);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLoginPage)
                      TextFormField(
                        keyboardType: TextInputType.text,
                        key: const ValueKey("username"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Incorrect UserName';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(),
                          ),
                          labelText: "Enter Username",
                          labelStyle: GoogleFonts.roboto(),
                        ),
                      ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: const ValueKey("email"),
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: "Enter Email",
                        labelStyle: GoogleFonts.roboto(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      key: const ValueKey("password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Incorrect Password';
                        }else{
                        return null;}
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(),
                        ),
                        labelText: "Enter Password",
                        labelStyle: GoogleFonts.roboto(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        startauthentication();
                        // Handle form submission here
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          // Now you can use _username, _email, and _password for further processing
                        }
                      },
                      child: isLoginPage
                          ? Text(
                              'LogIn',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              'SignUp',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: TextButton(
              onPressed: () {
                setState(() {
                  isLoginPage= !isLoginPage;
                });
              },
              child: isLoginPage?Text('Not a Member'): Text('Already a Member')
              ),
              ),
        ],
      ),
    );
  }
}
