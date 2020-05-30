//the screen for the chat,varies corresponding to the subject card selected

import 'package:flash_chat/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_list.dart';


final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static const String id = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  String messageText;
  var id;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    //getting the user who is currently logged in in the device
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        id = loggedInUser.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  var groupChatId;

  @override
  Widget build(BuildContext context) {
    if (id.hashCode < teacherId.hashCode) {
      /*Generating a new group chat id for the particular subject
                                               from the student and teacher id*/

      groupChatId = '$id-$teacherId';
    } else if (teacherId.hashCode > id.hashCode) {
      groupChatId = '$teacherId-$id';
    } else {
      groupChatId =
          '$teacherId'; //This group chat id is used as the unique identifier for the particular subject
    }

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('Scholastic'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(
              groupChatId: groupChatId,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore
                          .collection('messages')
                          .document(groupChatId)
                          .collection(groupChatId)
                          .add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': DateTime.now(),
                        'idFrom': id,
                        'idTo': teacherId,
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  /*This class deals with the
                                              whole list of messages for the particular subject*/
  final String groupChatId;

  MessagesStream({@required this.groupChatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //Fetches the messages from cloud firestore
      stream: _firestore
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .orderBy('time',
              descending: false) //Arranges the messages according to time
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                //loading indicator
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        /*Each message is treated as a message bubble,
                                                       with a message text in a customised conversation box*/
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          /*Each message is characterised with 4 properties*/
          final messageText = message.data['text']; //1.The actual message
          final messageSender =
              message.data['sender']; //2.Email address of the sender
          final idFrom = message.data['idFrom']; //3.id of the sender
          final idTo = message.data['idTo']; //4.id of the receiver

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
            /*IsMe is a boolean variable for understanding
                                               whether the message is send by me or the other user
                                                and message is arranged accordingly*/
            idFrom: idFrom,
            idTo: idTo,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            // returns the list of messages
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  //Messagebubble defines how each message should look in the screen
  final String sender;
  final String text;
  final String idFrom;
  final String idTo;
  final bool isMe;

  MessageBubble({this.sender, this.text, this.isMe, this.idFrom, this.idTo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
