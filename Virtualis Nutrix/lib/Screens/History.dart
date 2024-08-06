import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasee/Screens/AddNewMedicine.dart';
import 'package:firebasee/Screens/ViewExistingMedicines.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebasee/constants.dart';
import 'registration_screen.dart';
import 'welcome_screen.dart';
import 'package:firebasee/main.dart';
import 'drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasee/main.dart';
import 'registration_screen.dart';
import 'package:firebasee/Screens/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebasee/Screens/email.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

final _auth = FirebaseAuth.instance;
var selectedDate = DateTime.now();

String formatDate(DateTime selectedDate) =>
    new DateFormat("MMMM d, yyyy").format(selectedDate);
String email = (user.email);
get user => _auth.currentUser;

class MedicineHistory extends StatefulWidget {
  static const String id = 'medicine_history';

  @override
  _MedicineHistoryState createState() => _MedicineHistoryState();
}

class _MedicineHistoryState extends State<MedicineHistory> {
  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference reminders =
        FirebaseFirestore.instance.collection('History');
    return RefreshIndicator(
        onRefresh: _refresh,
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Virtualis Nutrix'),
                  backgroundColor: Colors.blueGrey,
                  actions: [
                    StreamBuilder(
                      stream: reminders.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: IconButton(
                              icon: Icon(Icons.email_outlined),
                              onPressed: () {
                                sendHistoryMail() async {
                                  var collection = FirebaseFirestore.instance
                                      .collection('History');
                                  var querySnapshot = await collection.get();
                                  for (var queryDocumentSnapshot
                                      in querySnapshot.docs) {
                                    Map<String, dynamic> data =
                                        queryDocumentSnapshot.data();
                                    var MedicineName = data['Medicine name'];
                                    var Nopills = data['No of pills'];
                                    var takenon = data['Date Taken'];
                                    var timee = data['Time'];
                                    String username =
                                        'virtualisnutrix@gmail.com';
                                    String password = 'Virtualisnutrix12';
                                    final smtpServer =
                                        gmail(username, password);
                                    String name = (user.displayName);
                                    final message = Message()
                                      ..from = Address(username)
                                      ..recipients.add(user.email)
                                      ..subject = 'Medicines Taken Till ' +
                                          formatDate(selectedDate)
                                      ..html = "<h1>Hey $name!</h1>\n<p>As per your request, this an email of the reminders you have taken till now:"
                                              " Medicine Name : $MedicineName,"
                                              " Amount of pills taken : $Nopills </p>"
                                              "Time Taken : $timee"
                                              " Date Taken : $takenon";
                                    try {
                                      final sendReport =
                                          await send(message, smtpServer);
                                      print('Message sent: ' +
                                          sendReport.toString());
                                    } on MailerException catch (e) {
                                      print('Message not sent.');
                                      for (var p in e.problems) {
                                        print('Problem: ${p.code}: ${p.msg}');
                                      }
                                    }
                                  }
                                }

                                sendHistoryMail();
                              }),
                        );
                      },
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                body: Container(
                  alignment: Alignment.centerLeft,
                  child: StreamBuilder(
                      stream: reminders.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Text("Loading...",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)));
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Text("You Have Not Taken Any Medicines!",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)));
                        }
                        return ListView(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                          children: snapshot.data!.docs.map((History) {
                            String? finalhistory = History['Medicine name'];
                            String? finalpills = History['No of pills'];
                            return InkWell(
                              child: Card(
                                color: Colors.white70,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            History['Medicine name'],
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Divider(
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Number of pills taken : ' +
                                            History['No of pills'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 1),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Taken on ' +
                                                History['Date Taken'] +
                                                ',',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 1),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            History['Time'],
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 30, 15),
                                            child: FlatButton(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.black)),
                                                onPressed: () async {
                                                  String? finalhistory =
                                                      History['Medicine name'];
                                                  String? finalpills =
                                                      History['No of pills'];

                                                  showModalBottomSheet<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                          child: Card(
                                                              child: Container(
                                                                  height: 250,
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          40,
                                                                          10,
                                                                          20),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            'Are you sure you want to delete the medicine?',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                            )),
                                                                        Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                15,
                                                                                20,
                                                                                15,
                                                                                0),
                                                                            child:
                                                                                Material(
                                                                              elevation: 0.0,
                                                                              color: Colors.blueGrey,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: MaterialButton(
                                                                                  onPressed: () {
                                                                                    History.reference.delete();
                                                                                    Navigator.pop(context, History.id);
                                                                                  },
                                                                                  minWidth: 100.0,
                                                                                  height: 42.0,
                                                                                  child: Text(
                                                                                    'Yes',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  )),
                                                                            )),
                                                                        Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              15,
                                                                              10,
                                                                              15,
                                                                              0),
                                                                          child:
                                                                              Material(
                                                                            elevation:
                                                                                0.0,
                                                                            color:
                                                                                Colors.blueGrey,
                                                                            borderRadius:
                                                                                BorderRadius.circular(30.0),
                                                                            child: MaterialButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context, History.id);
                                                                                },
                                                                                minWidth: 100.0,
                                                                                height: 42.0,
                                                                                child: Text(
                                                                                  'No',
                                                                                  style: TextStyle(color: Colors.white),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ]))));
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  "Delete Medicine 🗑",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey,
                                                    fontSize: 20,
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),
                drawer: MainDrawer())));
  }
}
