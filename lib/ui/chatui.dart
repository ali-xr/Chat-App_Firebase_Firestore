import 'package:chat/constants/chat_page_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatUi extends StatefulWidget {
  @override
  _ChatUiState createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> {
  FirebaseAuth _authUser = FirebaseAuth.instance;
  User? user;
  TextEditingController _messageController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void userOlibKel() async {
    try {
      final hozirgiUser = await _authUser.currentUser;
      if (hozirgiUser != null) {
        user = hozirgiUser;
      }
    } catch (e) {
      print("CHAT PAGE GET DATA ERROR: " + e.toString());
    }
  }

  void messageOlibKel() async {
    var a = await _firestore.collection('messages').get();
    for (var item in a.docs) {
      print(item.data());
    }
  }

  void messageStreamOlibKel() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var item in snapshot.docs) {
        print("STREAM: " + item.data().toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    messageStreamOlibKel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF4F4),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://visualpharm.com/assets/387/Person-595b40b75ba036ed117da139.svg"),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Ali Xurshetov",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .apply(color: Colors.black),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Online",
                  style: Theme.of(context).textTheme.subtitle2!.apply(
                        color: Colors.green,
                      ),
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _authUser.signOut();
              Navigator.pushReplacementNamed(
                context,
                'singinup',
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('uploadTime')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                List<BubbleMessage> messagelarWidget = [];
                for (var message in messages) {
                  final messageText = message['message'];
                  final emailText = message['email'];

                  final messageWidget = BubbleMessage(
                      messageText, emailText, _authUser.currentUser);
                  messagelarWidget.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.all(10),
                    children: messagelarWidget,
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              height: 61,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.grey)
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.face, color: Colors.black),
                              onPressed: () {}),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: kMessageSendTextFieldStyle,
                              style: TextStyle(color: Colors.black),
                              onChanged: (v) {},
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.photo_camera, color: Colors.black),
                            onPressed: () {},
                          ),
                          IconButton(
                            onPressed: () async {
                              await _firestore.collection('messages').add({
                                'message': _messageController.text,
                                'email':
                                    _authUser.currentUser!.email.toString(),
                                'uploadTime': DateTime.now(),
                              });
                              _messageController.clear();
                            },
                            icon: Icon(Icons.send, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: InkWell(
                      child: Icon(
                        Icons.keyboard_voice,
                        color: Colors.white,
                      ),
                      onLongPress: () {},
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BubbleMessage extends StatelessWidget {
  String message;
  String email;
  var userEmail;
  BubbleMessage(this.message, this.email, this.userEmail);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: userEmail.email.toString() == email.toString()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Material(
              color: Colors.indigo,
              borderRadius: userEmail.email.toString() == email.toString()
                  ? kOngTomon
                  : kChapTomon,
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  children: [
                    Text(
                      "$email",
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                      textAlign: userEmail.email.toString() == email.toString()
                          ? TextAlign.right
                          : TextAlign.left,
                    ),
                    Text(
                      "$message",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
