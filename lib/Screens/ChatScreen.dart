import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Firestore _firestore =Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Window"),
        actions: [
          IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.blue[50],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        //messageText+loggedInuser
                        _firestore.collection('messages').add({
                          'Text':messageText,
                          'Sender':loggedInUser.email
                        });
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ))
        ],
      )),
    );
  }
}
