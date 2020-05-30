//A screen that displays the list of subjects as cards and allows the user to select the corresponding subject

import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/reusable_card.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String teacherId;
String subject;
final _auth = FirebaseAuth.instance;

createDialogue(
  //Log out conformation
  BuildContext context,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.all(10.0),
            height: 250,
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Logout from scholastic ?',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "yes",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      onPressed: () {
                        _auth.signOut();
                        Navigator.pushNamed(context, WelcomeScreen.id);
                      },
                    ),
                    FlatButton(
                      color: Colors.lightBlueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "No",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

class ChatList extends StatefulWidget {
  static const String id = '/list';

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Future<String> getTeacherId(String subject) async {
    //function for getting the id of the teacher who is assigned to the particular subject
    try {
      var querySnapshot = await _firestore
          .collection('teachers')
          .where('subject', isEqualTo: subject)
          .getDocuments();
      final List<DocumentSnapshot> documents = querySnapshot.documents;

      for (var document in documents) {
        teacherId = document.data[
            'id']; //returns the id of the user who is the teacher of that subject
      }
      return teacherId;
    } catch (e) {
      print(e);
      return e;
    }
  }

  List<ReusableCard> _elements = []; // a list of subject cards

  @override
  Widget build(BuildContext context) {
    _elements.add(
      //Setting 6 subject cards with subject name subject1,subject2 etc.
      ReusableCard(
        color: Colors.greenAccent,
        onPress: () async {
          subject = 'subject1';
          teacherId = await getTeacherId(subject);
          print(teacherId);
          Navigator.pushNamed(context, ChatScreen.id);
        },
        cardChild: SubjectCard(
          subjectName: 'Subject1',
          teacherName: 'teacher name',
        ),
      ),
    );
    _elements.add(
      ReusableCard(
        color: Colors.deepOrangeAccent,
        onPress: () async {
          subject = 'subject2';
          teacherId = await getTeacherId(subject);
          print(teacherId);
          Navigator.pushNamed(context, ChatScreen.id);
        },
        cardChild: SubjectCard(
          subjectName: 'Subject2',
          teacherName: 'teacher name',
        ),
      ),
    );
    _elements.add(
      ReusableCard(
        color: Colors.cyanAccent,
        onPress: () async {
          subject = 'subject3';
          teacherId = await getTeacherId(subject);
          print(teacherId);
          Navigator.pushNamed(context, ChatScreen.id);
        },
        cardChild: SubjectCard(
          subjectName: 'Subject3',
          teacherName: 'teacher name',
        ),
      ),
    );
    _elements.add(
      ReusableCard(
        color: Colors.amberAccent,
        onPress: () async {
          subject = 'subject4';
          teacherId = await getTeacherId(subject);
          print(teacherId);
          Navigator.pushNamed(context, ChatScreen.id);
        },
        cardChild: SubjectCard(
          subjectName: 'Subject 4',
          teacherName: 'teacher name',
        ),
      ),
    );
    _elements.add(
      ReusableCard(
        color: Colors.deepPurpleAccent,
        onPress: () async {
          subject = 'subject5';
          teacherId = await getTeacherId(subject);
          print(teacherId);
          Navigator.pushNamed(context, ChatScreen.id);
        },
        cardChild: SubjectCard(
          subjectName: 'Subject5',
          teacherName: 'teacher name',
        ),
      ),
    );
    _elements.add(
      ReusableCard(
        color: Colors.redAccent,
        onPress: () async {
          subject = 'subject6';
          teacherId = await getTeacherId(subject);
          print(teacherId);
          Navigator.pushNamed(context, ChatScreen.id);
        },
        cardChild: SubjectCard(
          subjectName: 'Subject6',
          teacherName: 'teacher name',
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              createDialogue(context);
            },
          ),
        ],
        title: Text('Scholastic'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        children: _elements, //Displays the list of subject cards
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final String teacherName;

  SubjectCard({@required this.subjectName, @required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subjectName, style: kTitleTextStyle),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            teacherName,
            style: kTextStyle,
          ),
        ),
      ],
    );
  }
}
