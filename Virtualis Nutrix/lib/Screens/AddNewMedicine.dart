import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasee/Screens/home.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';




class AddMedicine extends StatefulWidget {
  static const String id = 'add_medicine';

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  get user => _auth.currentUser;

  late String ReminderName;
  late String ReminderDate;
  late String ReminderTime;
  late String PillNumber;
   late String AdditionalNotes;
   String? Time;
   String? Taken = "No";


  var selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked =  await showDatePicker(context: context,
        initialDate: selectedDate?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025)) as DateTime?;
    if (picked != null )
      setState(() {
        selectedDate = picked;
      });
  }

  String formatDate(DateTime selectedDate) => new DateFormat("MMMM d, yyyy").format(selectedDate);



  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  late String FinalTime = DateFormat("H:mm a").format(DateTime.now());


  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
         FinalTime = selectedTime.format(context);
       });}


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Add Reminder'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Provide a mEdicine Name';}
                        },
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        ReminderName = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.medical_services_outlined),
                        border: OutlineInputBorder(),
                        labelText: 'Medicine Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        PillNumber = value;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.format_list_numbered),

                          border: OutlineInputBorder(),
                        labelText: 'Amount of pills',
                      ),),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        AdditionalNotes = value;

                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.notes_rounded),

                          border: OutlineInputBorder(),
                        labelText: 'Any Additional Notes?',
                      ),),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                        showCursor: true,
                        readOnly: true,
                      style: TextStyle(color: Colors.black),
                      onTap: () {
                          _selectDate(context);
                      },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),

                            border: OutlineInputBorder(),
                          labelText: 'Date',
                      ),
                      controller: TextEditingController()..text = formatDate(selectedDate).toString(),
                    ),),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      showCursor: true,
                      readOnly: true,
                      style: TextStyle(color: Colors.black),
                      onTap: () {
                        _selectTime(context);
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.access_time_outlined),

                          border: OutlineInputBorder(),
                          labelText: 'Time',
                      ),
                      controller: TextEditingController()..text = FinalTime.toString(),
                    ),),
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
                                'Date' : formatDate(selectedDate).toString(),
                                'Time' : FinalTime,
                              'Taken' : Taken,
                                'User email' : user.email,
                              });
                              Navigator.pop(context, Home.id);
                            },
                            child: Text(
                              'Add Reminder',
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

