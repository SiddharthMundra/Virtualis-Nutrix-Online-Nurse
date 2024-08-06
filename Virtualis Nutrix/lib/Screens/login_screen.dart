import 'package:firebasee/Screens/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasee/Screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasee/main.dart';
import 'package:firebasee/Screens/AppInfo.dart';
import 'package:firebasee/Screens/welcome_screen.dart';


class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  var email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    onChanged: (value) {
                      password=value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(120, 20, 120, 0),
                      child: Material(
                        elevation: 0.0,
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20.0),
                        child: MaterialButton(
                        onPressed: ()  async{
                          try{
                            final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                            final uid = newUser!.user!.uid;
                            print ('User logged in with ID = ' + uid  );
                              Navigator.pushNamed(context, Home.id);
                          }
                          catch (e) {
                            print(e);
                          }},
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      )
                    ),
                ),
              Container(
                height: 30,
                    padding: const EdgeInsets.fromLTRB(100,0,100,0),
                    child: Material(
                      elevation: 0.0,
                      child: MaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, ForgotPassword.id);
                    },
                    textColor: Colors.blue,
                    child: Text('Forgot Password?',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                ),
              ],
            )));
  }
}


