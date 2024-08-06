import 'package:firebasee/Screens/AddNewMedicine.dart';
import 'package:firebasee/Screens/ForgotPassword.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:android_alarm_manager/android_alarm_manager.dart';


FlutterLocalNotificationsPlugin localNotificationsPlugin =
FlutterLocalNotificationsPlugin();

initializeNotifications() async {
  var initializeAndroid = AndroidInitializationSettings('ic_launcher');
  var initializeIOS = IOSInitializationSettings();
  var initSettings = InitializationSettings(
      android: initializeAndroid, iOS: initializeIOS);
  await localNotificationsPlugin.initialize(initSettings);

  }

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DrinkWaterReminder(),
      ),
    );
  }
}

class DrinkWaterReminder extends StatefulWidget {
  static const String id = 'DrinkWaterReminder';

  @override
  State<DrinkWaterReminder> createState() => _DrinkWaterReminderState();
}

class _DrinkWaterReminderState extends State<DrinkWaterReminder> {

  singleNotification(DateTime datetime, String message, String subtext,
      int hashcode,
      {String? sound}) async {
    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      importance: Importance.max,
      priority: Priority.max,
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(
        android: androidChannel, iOS: iosChannel);
    localNotificationsPlugin.schedule(
        hashcode, message, subtext, datetime, platformChannel,
        payload: hashcode.toString());
  }
  double _currentSliderValue = 20;

  @override

      Widget build(BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Drink Water Reminder"),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blueGrey,
              ),
              backgroundColor: Colors.white,
              body: Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Image.asset('assets/Water reminder.png'),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                  ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 300, 0, 0),
                   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(child: Text("Select Reminder Notification Interval: ", style: TextStyle(color: Colors.black, fontSize: 20),)),
                        Row(
                          children: <Widget>[
                              Container(
                                  height: 60,
                                  padding: EdgeInsets.fromLTRB(100, 0, 90, 0),
                                  child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Colors.blue,
                                      inactiveTrackColor: Colors.blueAccent,
                                      trackShape: RoundedRectSliderTrackShape(),
                                      trackHeight: 4.0,
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                      thumbColor: Colors.blue,
                                      overlayColor: Colors.blue,
                                      overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                                      tickMarkShape: RoundSliderTickMarkShape(),
                                      activeTickMarkColor: Colors.blue,
                                      inactiveTickMarkColor: Colors.blue,
                                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                      valueIndicatorColor: Colors.blue,
                                      valueIndicatorTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),), child: Slider(
                                    value: _currentSliderValue,
                                    min: 0,
                                    max: 100,
                                    divisions: 5,
                                    label: _currentSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _currentSliderValue = value;
                                        DateTime now = DateTime.now().toUtc().add(
                                            Duration(minutes: _currentSliderValue.toInt()));
                                        singleNotification(
                                            now,
                                            "Virtualis Nutrix",
                                            "Its time to drink water!!",
                                            98123871
                                        );
                                      });
                                    },
                                  ),),
                              )
                          ],
                        ),
                         Center(child: Text( _currentSliderValue.toString() + ' Minutes', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
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

                      ],

                    ),

                // ),
              ]
              ),
            )
        );
      }
    }
