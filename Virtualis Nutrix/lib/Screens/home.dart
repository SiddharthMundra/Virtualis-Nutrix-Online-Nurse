import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasee/Screens/AddNewMedicine.dart';
import 'package:firebasee/Screens/History.dart';
import 'package:firebasee/Screens/ViewExistingMedicines.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebasee/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'registration_screen.dart';
import 'welcome_screen.dart';
import 'package:firebasee/main.dart';
import 'drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasee/main.dart';
import 'registration_screen.dart';
import 'package:intl/intl.dart';
import 'package:add_2_calendar/add_2_calendar.dart';




class HomePageFinal extends StatefulWidget {
  @override
  _HomePageFinalState createState() => _HomePageFinalState();
}

class _HomePageFinalState extends State<HomePageFinal> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;


  void updateUI(){
    setState(() {
      //You can also make changes to your state here.
    });
  }
  late var DateTaken;
  late String oldName;
  late String oldPills;
  late var TimeTaken;
  late var oldEmail;

  String? _hour, _minute;


  Future <void> _refresh() async {
    setState(() {
    });
  }

  String formatDateTaken(DateTime DateTaken) => new DateFormat("MMMM d, yyyy").format(DateTaken);


  CollectionReference reminders = FirebaseFirestore.instance.collection('Reminders');

  @override
  Widget build(BuildContext context) {
    CollectionReference reminders =
    FirebaseFirestore.instance.collection('Reminders');


    return RefreshIndicator(
        onRefresh: _refresh,
        child: WillPopScope(
        onWillPop: () async => false,
        child : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Virtualis Nutrix'),
              backgroundColor: Colors.blueGrey,
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: IconButton(icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () async {
                      var collection = FirebaseFirestore.instance.collection(
                          'Reminders');
                      var querySnapshot = await collection.get();
                      for (var queryDocumentSnapshot in querySnapshot.docs) {
                        Map<String, dynamic> data = queryDocumentSnapshot
                            .data();
                        var reminderdate = data['Date'];
                        var MedicineName = data['Medicine name'];
                        final event = Event(
                          title: (MedicineName),
                          description: 'Its time to take your medicine!',
                          startDate: DateTime.now().add(Duration(hours: 34)),
                          endDate: DateTime.now().add(Duration(minutes: 5)),
                          allDay: false,
                        );
                        Add2Calendar.addEvent2Cal(event);
                      }
                    }),
                ),
              ],
            ),

            body:
            Container(
              alignment: Alignment.centerLeft,
              child: StreamBuilder(
                  stream: reminders.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("Loading...", style: TextStyle(color: Colors.black, fontSize: 20)));
                    }
    if (snapshot.data!.docs.isEmpty) {
    return Center(child: Text("You Have No Reminders!", style: TextStyle(color: Colors.black, fontSize: 20)));}

                      return ListView(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          children: snapshot.data!.docs.map((Reminders) {
                            String alarmdate = Reminders['Date'];
                            oldEmail = Reminders['User email'];
                              return Card(
                                color: Colors.white70,
                                margin: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () => MedicineDetailsPage(),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 0, 0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              Reminders['Medicine name'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),),
                                          ),

                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
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
                                        padding: EdgeInsets.fromLTRB(
                                            10, 10, 0, 0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          Reminders['No of pills'] + " pills",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 0, 1),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              Reminders['Date'] + ',',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            )
                                            ,
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 0, 1),
                                            alignment: Alignment.centerLeft,
                                            child: Text(Reminders['Time'],
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15,
                                              ),),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Additional Notes: ' +
                                            Reminders['Notes'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(
                                                  10, 10, 30, 15),
                                              child: FlatButton(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.black)
                                                ),
                                                onPressed: () async {
                                                  DateTaken = DateTime.now();
                                                  oldName =
                                                  Reminders['Medicine name'];
                                                  oldPills =
                                                  Reminders['No of pills'];
                                                  TimeTaken =
                                                      DateFormat.jm().format(
                                                          DateTime.now());
                                                  FirebaseFirestore.instance
                                                      .collection('History')
                                                      .add({
                                                    'Medicine name': oldName,
                                                    'No of pills': oldPills,
                                                    'Date Taken': formatDateTaken(
                                                        DateTaken).toString(),
                                                    'Time': TimeTaken,
                                                  });
                                                  print(oldEmail);
                                                  Reminders.reference.delete();
                                                  // Reminders.reference.delete();
                                                },
                                                child: Text(
                                                  "Medicine Taken  ✔",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                        ,),
                                    ],
                                  ),
                                ),
                              );
                            }
                          ).toList(),
                      );
                    }
                  ),
            ),


            drawer: MainDrawer()
        )));
    }

  }


class Home extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  List<Widget> _screens = [
    HomePageFinal(), MedicineHistory(),
  ];

  void updateUI(){
    setState(() {
      //You can also make changes to your state here.
    });
  }

  var _selectedIndex = 0;
  get user => _auth.currentUser;


  void onTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  Future <void> _refresh() async {}

  @override
  final _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    CollectionReference reminders =
    FirebaseFirestore.instance.collection('Reminders');

    return WillPopScope(
        onWillPop: () async => false,
        child : Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddMedicine.id);
              },
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.add),
            ),
            backgroundColor: Colors.white,
            body: _screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text( 'Home')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.access_time), title: Text( 'History'),backgroundColor: Colors.blue)],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                onTap: onTapped,
              ),
            drawer: MainDrawer()
        )
    );
  }
}



class MedicineDetailsPage extends StatefulWidget {
  @override
  _MedicineDetailsPageState createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference Reminders =
    FirebaseFirestore.instance.collection('Reminders');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Info'),),
        body: Padding(
          padding: EdgeInsets.fromLTRB(8, 32, 8, 32),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Medicine name', textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                    'Medicine Details'
                ),
                SizedBox(height: 20,),
                Text('Date and Time')

              ],
            ),
          ),
        )
    );
  }
}

