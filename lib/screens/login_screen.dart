//The screen for user login

import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'chat_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'welcome_screen.dart';
import 'package:flash_chat/screens/selection.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dropdownValue = 'Student';
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        //Loading indicator
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    email = value; //Getting user email
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value; //Getting user password
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              SizedBox(
                height: 24.0,
              ),
              Center(
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.lightBlueAccent,
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 28,
                  elevation: 20,
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue =
                          newValue; //Checking whether the user is a student or teacher
                    });
                  },
                  items: <String>['Student', 'Teacher']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Log In',
                onPress: () async {
                  setState(() {
                    showSpinner = true; //Loading indicator
                  });
                  try {
                    //Using firebase to authenticate the user using email and password

                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      if (dropdownValue == 'Student') {
                        Navigator.pushNamed(context, ChatList.id);
                      } else {
                        Navigator.pushNamed(context, ChatList.id);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    //user authentication failed
                    print(e);
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "ALERT",
                      desc: "unable to login",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "back",
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
              SizedBox(
                height: 30,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "New to scholastic ?",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  FlatButton(
                    //Register button
                    onPressed: () {
                      Navigator.pushNamed(context, Selection.id);
                    },
                    color: Colors.white,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
