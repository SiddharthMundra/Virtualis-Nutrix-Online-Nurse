import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:firebasee/main.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasee/Screens/forgotpasswordreturnpage.dart';



class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;
   late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
        ),
        body:
        Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email address',
                    ),),),
                Padding(
                  padding: EdgeInsets.fromLTRB(100, 20, 100, 0),
                  child: Container(
                    child: Material(
                      elevation: 0.0,
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20.0),
                      child: MaterialButton(
                        onPressed: () {
                          try{
                             _auth.sendPasswordResetEmail(email: email);
                              Navigator.pushNamed(context, ForgotPasswordReturn.id);
                          }
                          catch (e) {
                            print(e);
                          }},
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Send Reset E-mail',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(100,5,100,0),
                  child: Material(
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      textColor: Colors.blue,
                      child: Text('Sign In Page',style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
        ),
    );
  }
}


