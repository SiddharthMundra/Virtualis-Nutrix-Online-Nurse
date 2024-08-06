
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasee/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebasee/Screens/email.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/User_Manual_Virtualis_Nutrix.pdf');
}
class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;
  late String email;
  late String password;
  late String number;
  late String name;


  final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_box_sharp),
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      number = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
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
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    onChanged: (value) {
                      password=value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
        padding: const EdgeInsets.fromLTRB(100,20,100,0),
        child: Material(
          elevation: 0.0,
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
                  child: Text("Sign Up"),
                        textColor: Colors.white,
                        onPressed: () async {
                          _firestore.collection('User').add({
                            'email': email,
                            'name': name,
                            'number': number,
                          });
                          try {
                            final newUser = await _auth
                                .createUserWithEmailAndPassword(email: email,
                                password: password);
                            FirebaseAuth.instance.currentUser!.updateDisplayName(name);
                            Navigator.pushNamed(context, LoginScreen.id);
                          }
                          catch (e) {
                            print(e);
                          }
                          sendMail() async {
                            String username = 'virtualisnutrix@gmail.com';
                            String password = 'Virtualisnutrix12';
                            final smtpServer = gmail(username, password);

                            final message = Message()
                              ..from = Address(username)
                              ..recipients.add(email)
                              ..subject = 'User Manual'
                              ..html = "<h1>Hey $name</h1>\n<p>Thank you for registering as a user on Virtualis Nutrix! The user manual is "
                                  "attached to this email. I hope you have a great experience using this app!"
                                  "Have any queries? Contact virtualisnutrix@gmail.com for support!!! </p>"
                            ..attachments =  [
                            FileAttachment(File('assets/User_Manual_Virtualis_Nutrix.pdf'),)
                            ];
                            try {
                              final sendReport = await send(message, smtpServer);
                              print('Message sent: ' + sendReport.toString());
                            } on MailerException catch (e) {
                              print('Message not sent.');
                              for (var p in e.problems) {
                                print('Problem: ${p.code}: ${p.msg}');
                              }
                            }
                          }
                          sendMail();
                        }),
                  ),
                ),
      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    textColor: Colors.blue,
                    child: Text('Have an account? Sign In', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            )));
  }
}

