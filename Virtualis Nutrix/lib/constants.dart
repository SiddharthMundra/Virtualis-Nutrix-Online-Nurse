import 'package:flutter/material.dart';


const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class CustomTextField extends StatelessWidget {
final TextEditingController controller;
final String hint;
final TextInputType type;

CustomTextField({required this.controller, required this.hint, this.type = TextInputType.text});

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        maxLines: 1,
        keyboardType: type,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black54,
        ),
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: Icon(Icons.label),
          border: InputBorder.none,
        ),
        controller: controller,
      ),
    ),
  );
}
}
