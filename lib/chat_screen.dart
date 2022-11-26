import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chats/68pxl3MiWpk28totIOIQ/messages")
            .snapshots(),
        builder: (context, streamSnapshot) {
          if(streamSnapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                return Text(streamSnapshot.data!.docs[index]['text']);
              }));
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseFirestore.instance
            .collection("chats/68pxl3MiWpk28totIOIQ/messages")
            .add({'text':"data added"});
        
      }),
    );
  }
}
