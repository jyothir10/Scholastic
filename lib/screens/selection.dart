//Select whether the user is a student or teacher for the purpose of registration

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/Teacherregistrationscreen.dart';

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
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/training_icon.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text:
                  'Student', //As the user is a student it takes to the student registration screen
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text:
                  'Teacher', //As the user is a teacher it takes to the teacher registration screen
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
