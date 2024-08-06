
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasee/constants.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebasee/Screens/registration_screen.dart';
import 'package:http/http.dart' as http;

get user => _auth.currentUser;
final _auth = FirebaseAuth.instance;

// sendMail() async {
//   String username = 'virtualisnutrix@gmail.com';
//   String password = 'Virtualisnutrix12';
//   final smtpServer = gmail(username, password);
//
//   final message = Message()
//     ..from = Address(username, 'Your name')
//     ..recipients.add(user.email)
//     ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
//     ..bccRecipients.add(Address('bccAddress@example.com'))
//     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
//     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//     ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
//
//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Message sent: ' + sendReport.toString());
//   } on MailerException catch (e) {
//     print('Message not sent.');
//     for (var p in e.problems) {
//       print('Problem: ${p.code}: ${p.msg}');
//     }
//   }
// }