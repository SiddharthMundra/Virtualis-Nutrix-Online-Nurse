import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasee/Screens/AddNewMedicine.dart';
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

class EditMedicine extends StatefulWidget {
  static const String id = 'edit_medicine';

  @override
  _EditMedicineState createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  get user => _auth.currentUser;

  late String ReminderName;
  late String ReminderDate;
  late String ReminderTime;
  late String PillNumber;
  late String AdditionalNotes;
  late String Date;
  late String Time;
  late String Taken = "No";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Reminder'),
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
                      ReminderName = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Medicine Name',
                        icon: Icon(Icons.medical_services_outlined)
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      PillNumber = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount of pills',
                        icon: Icon(Icons.format_list_numbered)
                    ),),),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      AdditionalNotes = value;

                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Any Additional Notes?',
                        icon: Icon(Icons.notes_rounded)
                    ),),),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      Date = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                        icon: Icon(Icons.calendar_today_outlined)
                    ),),),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      Time = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Time',
                        icon: Icon(Icons.access_time_outlined)
                    ),),),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                      height: 60,
                      padding: EdgeInsets.fromLTRB(100, 20, 100, 0),
                      child: Material(
                        elevation: 0.0,
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20.0),
                        child: FlatButton(
                          onPressed: () async {
                            _firestore.collection('Reminders').add({
                              'Medicine name': ReminderName,
                              'No of pills': PillNumber,
                              'Notes' : AdditionalNotes,
                              'Taken' : Taken
                            });
                            Navigator.pushNamed(context, Home.id);
                          },
                          child: Text(
                            'Update Reminder',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                  ),
                ),
              ]
          ),
        ));
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}


class ConfirmDelete extends StatelessWidget {
  static const String id = 'confirm_delete';
  @override
  Widget build(BuildContext context) {
    CollectionReference reminders =
    FirebaseFirestore.instance.collection('Reminders');
    return Container(
      child: StreamBuilder(
          stream: reminders.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading..."));
            }
            return Column(
              children: snapshot.data!.docs.map((Reminders)
              {
                child:
                return Card(
                  child: Column(
                    children: [
                      MaterialButton(onPressed: () {
                        Reminders.reference.delete();
                        Navigator.pushNamed(context, Home.id);
                      },
                        child: Text('Yes',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      MaterialButton(onPressed: () {
                        Navigator.pushNamed(context, Home.id);
                      },

                        child:
                        Text('No', style: TextStyle(
                          color: Colors.purple,
                          fontSize: 15,
                        ),
                        ),
                      ),
                    ],
                  ),
                );

              }).toList(),);

          }

      ),);
  }


}