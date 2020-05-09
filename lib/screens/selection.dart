import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/Teacher registration screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';

class Selection extends StatefulWidget {
  static const String id = '/selec';

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Student',
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'Teacher',
              onPress: () {
                Navigator.pushNamed(context, TeacherRegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
