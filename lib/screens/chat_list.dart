import 'package:flutter/material.dart';
import 'package:flash_chat/components/reusable_card.dart';
import 'package:flash_chat/constants.dart';

class ChatList extends StatefulWidget {
  static const String id = '/list';

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<ReusableCard> _elements = [
    ReusableCard(
      color: Colors.lightBlueAccent,
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Subject 1',
        teacherName: 'teacher name1',
      ),
    ),
    ReusableCard(
      color: Colors.deepOrangeAccent,
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Subject 2',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.cyanAccent,
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Subject 3',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.amberAccent,
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Subject 4',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.deepPurpleAccent,
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Subject 5',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      color: Colors.redAccent,
      onPress: null,
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
