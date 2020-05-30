//This screen is meant for student registration

import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'welcome_screen.dart';

final _firestore = Firestore.instance;

class RegistrationScreen extends StatefulWidget {
  static const String id = '/reg';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String name;
  String branch;
  String semester;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(          //Loading indicator
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
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
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value; //getting the student email
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value; //getting the student password
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  )),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value; //getting the student name
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your name',
                  )),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.blueAccent,
                  hint: Text('Branch'),
                  value: branch,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 28,
                  elevation: 20,
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                  onChanged: (String newValue) {
                    setState(() {
                      branch = newValue; //getting the student branch
                    });
                  },
                  items: <String>[
                    'CSE',
                    'CE',
                    'ME',
                    'ECE',
                    'EEE',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.blueAccent,
                  hint: Text('Semester'),
                  value: semester,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 28,
                  elevation: 20,
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                  onChanged: (String newValue) {
                    setState(() {
                      semester = newValue; //getting the semester
                    });
                  },
                  items: <String>[
                    'S1',
                    'S2',
                    'S3',
                    'S4',
                    'S5',
                    'S6',
                    'S7',
                    'S8'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Flexible(
                child: RoundedButton(
                  color: Colors.blueAccent,
                  text: 'Register',
                  onPress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      //Creating new user in firebase using the credentials provided by the student

                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      _firestore.collection('students').add({
                        'name': name,
                        'branch': branch,
                        'semester': semester,
                        'id': newUser.user.uid,
                      });
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatList.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "ALERT",
                        desc: "unable to register student",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "back",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, WelcomeScreen.id),
                            width: 120,
                          )
                        ],
                      ).show();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
