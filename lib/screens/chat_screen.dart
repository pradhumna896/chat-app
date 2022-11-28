import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/chat/messages.dart';
import 'package:flutterchatapp/chat/new_messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterChat"),
        actions: [
          DropdownButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
               DropdownMenuItem(
                    value: "Logout",
                    child: Container(
                      child: Row(
                  children: const [Icon(Icons.logout,color: Colors.black,),
                  SizedBox(width: 8,),
                  Text("Logout")
                  ],
                ),
                    ))
              ],
             
              onChanged: (itemIdentifier) {
                if (itemIdentifier == "Logout") {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body:Container(
        child: Column(children: [
          Expanded(child: Messages()),
          NewMessages()
        ],),
      ),
   
    );
  }
}
