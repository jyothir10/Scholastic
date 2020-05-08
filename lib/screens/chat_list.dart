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
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Maths',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'maths',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'maths',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Maths',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Maths',
        teacherName: 'teacher name',
      ),
    ),
    ReusableCard(
      onPress: null,
      cardChild: SubjectCard(
        subjectName: 'Maths',
        teacherName: 'teacher name',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
