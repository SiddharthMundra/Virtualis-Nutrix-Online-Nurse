
import 'package:firebasee/Screens/AppInfo.dart';
import 'package:firebasee/Screens/DrinkWaterReminder.dart';
import 'package:firebasee/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'package:firebasee/main.dart';
import 'registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasee/Screens/login_screen.dart';


class MapUtils {

  MapUtils._();

  static Future<void> openMap() async {
    String googleUrl = 'https://www.google.com/maps/search/medicine+store+near+me/@18.4896636,73.9336016/';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}


get user => _auth.currentUser;
final _auth = FirebaseAuth.instance;

class UserEmail extends StatefulWidget {

  @override
  _UserEmailState createState() => _UserEmailState();
}

class _UserEmailState extends State<UserEmail> {


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MainDrawer extends StatelessWidget {


  Widget build(BuildContext context) {
        return Drawer(
          child: Column(
            children: <Widget> [
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      color: Colors.blueGrey,
                      child: Center(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(top: 30),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage('assets/user pfp.png')),
                                    ),
                                  )
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (user.displayName),
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text((user.email),
                                  style: TextStyle(fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                  )
                  ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 1, 0),
                child: ListTile(
                    leading: Icon(Icons.water_outlined),
                    title: Text('Drink Water Reminder',
                      style: TextStyle(fontSize: 15, color: Colors.black, ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, DrinkWaterReminder.id);
                    }),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('About App',
                      style: TextStyle(fontSize: 15, color: Colors.black, ),
                    ),
                    onTap: () {
                      print(user);
                      Navigator.pushNamed(context, AppInfo.id);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 10, 1, 0),
                child: ListTile(
                    leading: Icon(Icons.medical_services_outlined),
                    title: Text('Medicines over? Click Here!',
                      style: TextStyle(fontSize: 15, color: Colors.black, ),
                    ),
                    onTap: () {
                      MapUtils.openMap();
                    }),
              ),
          Padding(
            padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
            child:
              ListTile(
                  leading: Icon(Icons.arrow_back),
                  title: Text('Sign Out',
                    style: TextStyle(fontSize: 15, color: Colors.black,),
                  ),
                  onTap: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  }),
          ),
            ],
          ),
        );
      }
    }

