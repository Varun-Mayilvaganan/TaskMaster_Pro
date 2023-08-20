import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';


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

        FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 202, 188, 240), Color.fromRGBO(133, 67, 255, 1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 10,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        height: 120,
                        child: Image.asset('assets/images/todoauths.png'),
                      ),
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
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      SizedBox(height: 20),
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
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        key: const ValueKey("password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Incorrect Password';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(),
                          ),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          primary: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: startauthentication,
                        child: Text(
                          isLoginPage ? 'Log In' : 'Sign Up',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        },
                        child: Text(
                          isLoginPage ? 'Create a new account' : 'Already have an account? Log In',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


