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



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        Home.id : (context) => Home(),
        ForgotPassword.id : (context) => ForgotPassword(),
        AppInfo.id : (context) => AppInfo(),
        AddMedicine.id : (context) => AddMedicine(),
        ForgotPasswordReturn.id : (context) => ForgotPasswordReturn(),
        ConfirmDelete.id : (context) => ConfirmDelete(),
        EditMedicine.id : (context) => EditMedicine(),
        MedicineHistory.id : (context) => MedicineHistory(),
        DrinkWaterReminder.id : (context) => DrinkWaterReminder(),
      },
    );
  }
}

