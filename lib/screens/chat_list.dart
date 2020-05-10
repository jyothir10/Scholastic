import 'package:flash_chat/screens/chat_screen.dart';
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
  Future<String> getTeacherId(String subject) async {
    try {
      var querySnapshot = await _firestore
          .collection('teachers')
          .where('subject', isEqualTo: subject)
          .getDocuments();
      final List<DocumentSnapshot> documents = querySnapshot.documents;

      for (var document in documents) {
        teacherId = document.data['id'];
      }
      return teacherId;
    } catch (e) {
      print(e);
      return e;
    }
  }

  List<ReusableCard> _elements = [];

  @override
  Widget build(BuildContext context) {
    _elements.add(
      ReusableCard(
        color: Colors.lightBlueAccent,
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
        color: Colors.deepPurpleAccent,
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
