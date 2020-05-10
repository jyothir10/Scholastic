import 'package:flutter/material.dart';
import 'package:flash_chat/components/reusable_card.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String teacherId;
String subject;

class ChatList extends StatefulWidget {
  static const String id = '/list';

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
//  Future<String> getTeacherId(String subject) async {
//    try {
//      var querySnapshot = await _firestore
//          .collection('teachers')
//          .where('subject', isEqualTo: subject)
//          .getDocuments();
//      final List<DocumentSnapshot> documents = querySnapshot.documents;
//
//      for (var document in documents) {
//        teacherId = document.data['id'].toString();
//      }
//      return teacherId;
//    } catch (e) {
//      print(e);
//      return e;
//    }
//  }

  List<ReusableCard> _elements = [
    ReusableCard(
      color: Colors.lightBlueAccent,
      onPress: () async {
        subject = 'subject1';

        try {
          var querySnapshot = await _firestore
              .collection('teachers')
              .where('subject', isEqualTo: subject)
              .getDocuments();
          final List<DocumentSnapshot> documents = querySnapshot.documents;

          for (var document in documents) {
            teacherId = document.data['id'].toString();
          }
        } catch (e) {
          print(e);
        }

        print(teacherId);
      },
      cardChild: SubjectCard(
        subjectName: 'Subject1',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.deepOrangeAccent,
      onPress: () async {
        subject = 'subject2';

        try {
          var querySnapshot = await _firestore
              .collection('teachers')
              .where('subject', isEqualTo: subject)
              .getDocuments();
          final List<DocumentSnapshot> documents = querySnapshot.documents;

          for (var document in documents) {
            teacherId = document.data['id'].toString();
          }
        } catch (e) {
          print(e);
        }

        print(teacherId);
      },
      cardChild: SubjectCard(
        subjectName: 'Subject2',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.cyanAccent,
      onPress: () {
        subject = 'subject3';
        print(teacherId);
      },
      cardChild: SubjectCard(
        subjectName: 'Subject3',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.amberAccent,
      onPress: () {
        subject = 'subject4';
        print(teacherId);
      },
      cardChild: SubjectCard(
        subjectName: 'Subject 4',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.deepPurpleAccent,
      onPress: () {
        subject = 'subject5';
      },
      cardChild: SubjectCard(
        subjectName: 'Subject5',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.redAccent,
      onPress: () {
        subject = 'subject6';
      },
      cardChild: SubjectCard(
        subjectName: 'Subject 6',
        teacherName: 'teacher name',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        children: _elements,
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
