import 'package:firebasee/Screens/AddNewMedicine.dart';
import 'package:firebasee/Screens/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasee/Screens/welcome_screen.dart';
import 'package:firebasee/Screens/home.dart';
import 'package:firebasee/Screens/registration_screen.dart';
import 'package:firebasee/Screens/login_screen.dart';
import 'package:firebasee/Screens/AppInfo.dart';

class ForgotPasswordReturn extends StatefulWidget {
  static const String id = 'ForgotPasswordReturnPage';

  @override
  _ForgotPasswordReturnState createState() => _ForgotPasswordReturnState();
}

class _ForgotPasswordReturnState extends State<ForgotPasswordReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 70.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,40,0,0),
                  child: Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '''An email has been sent to you!
                        
Click on the link provided to reset your password''',
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,0),
              child: Material(
                elevation: 0.0,
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 100.0,
                  height: 42.0,
                  child: Text(
                    'Return to the log in screen',
                    style: TextStyle(color: Colors.white),
                  ),),),
            ),
          ],
        ),
      ),
    );
  }
}

