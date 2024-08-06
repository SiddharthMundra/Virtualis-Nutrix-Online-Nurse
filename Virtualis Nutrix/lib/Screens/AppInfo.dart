import 'package:firebasee/Screens/AddNewMedicine.dart';
import 'package:firebasee/Screens/ForgotPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasee/Screens/welcome_screen.dart';
import 'package:firebasee/Screens/home.dart';
import 'package:firebasee/Screens/registration_screen.dart';
import 'package:firebasee/Screens/login_screen.dart';
import 'package:firebasee/Screens/AppInfo.dart';
import 'package:firebasee/Screens/forgotpasswordreturnpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebasee/Screens/ViewExistingMedicines.dart';
import 'package:firebasee/Screens/History.dart';
import 'package:firebasee/Screens/DrinkWaterReminder.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AppInfo extends StatefulWidget {
  static const String id = 'about_app';

  @override
  _AppInfoState createState() => _AppInfoState();

}

class _AppInfoState extends State<AppInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtualis Nutrix"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Image.asset('assets/logo.png'),
          ),
           Text( '''App Name: Virtualis Nutrix
        App Version: 1.0.0
            ''', style: TextStyle(color: Colors.black, fontSize: 20)),
              Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
                        child: Container(
                            height: 60,
                            padding: EdgeInsets.fromLTRB(100, 20, 90, 0),
                            child: Material(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20.0),
                              child: MaterialButton(
                                onPressed: () {

    Navigator.pop(context, Home.id);

                                },
                                minWidth: 200.0,
                                height: 60.0,
                                child: Text(
                                  'Return to the Home Page',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                        ),
                      ),
        ),

          ]
      ),


        );

  }
}