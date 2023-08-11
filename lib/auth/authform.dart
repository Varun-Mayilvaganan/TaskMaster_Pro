import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
 // String _username ='';
  //String _email = '';
  //String _password = '';
  bool isLoginPage = false;

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
                    if(!isLoginPage)
                      TextFormField(
                        keyboardType: TextInputType.text,
                        key: const ValueKey("username"), // Use a unique string value
                        validator: (value) {
                          if (value == null || value.isEmpty ) {
                            return 'Incorrect UserName';
                          }
                          return null;
                        },
                        /*onSaved: (value) {
                          _username = value!;
                        },*/
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
                      key: const ValueKey("email"), // Use a unique string value
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      /*onSaved: (value) {
                        _email = value!;
                      },*/
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
                      keyboardType: TextInputType.emailAddress,
                      key: const ValueKey("password"), // Use a unique string value
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Incorrect Password';
                        }
                        return null;
                      },
                      /*onSaved: (value) {
                        _password = value!;
                      },*/
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
  
                        ),
                        labelText: "Enter Password",
                        labelStyle: GoogleFonts.roboto(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                     ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent, // Set the background color here
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )),

                      onPressed: () {
                        // Handle form submission here
                      },
                      child: isLoginPage
                      ? Text('LogIn',
                      style: GoogleFonts.
                      roboto(
                        fontSize: 16
                        ),
                        )
                       : Text('SignUp',
                      style: GoogleFonts.
                      roboto(
                        fontSize: 16
                        ),
                        )  
                    ),
            
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
