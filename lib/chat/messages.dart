import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
      builder: (context ,AsyncSnapshot chatSnapshot){
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return Center( child: CircularProgressIndicator(),);
        }
        final chatDocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatSnapshot.data.docs.length,
          itemBuilder: (
            
            (context, index) {
          return Text(chatDocs[index]['text']);
        }
        )
        );
        
      
    });
    
  }
}