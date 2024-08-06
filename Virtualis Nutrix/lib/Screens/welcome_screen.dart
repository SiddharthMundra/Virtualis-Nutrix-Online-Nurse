import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
      appBar: AppBar(
        title: Text("Virtualis Nutrix"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.white,
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
                  padding: const EdgeInsets.fromLTRB(20,40,0,0),
                  child: Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome to Virtualis Nutrix!!",
                              style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),
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
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,8,15,0),
              child: Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 0.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 100.0,
                  height: 42.0,
                  child: Text(
                    'New here? Sign Up!',
                    style: TextStyle(color: Colors.white),
                  ),),),
            ),
          ],
        ),
      ),
        ),
    );
  }
}
