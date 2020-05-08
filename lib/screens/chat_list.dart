import 'package:flutter/material.dart';
import 'package:flash_chat/components/reusable_card.dart';

class ChatList extends StatefulWidget {
  static const String id = '/list';

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<ReusableCard> _elements = [
    ReusableCard(
      colour: Colors.grey,
      onPress: null,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Maths'),
          SizedBox(
            height: 15,
          ),
          Text('Teacher name'),
        ],
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
