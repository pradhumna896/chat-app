// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:core';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.userName,
  
    this.isMe, {
    required this.key,
  });
  final String message;
  final String userName;
  
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: isMe ? Colors.grey[400] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft:
                      !isMe ? const Radius.circular(0) : Radius.circular(12),
                  bottomRight:
                      isMe ? const Radius.circular(0) : Radius.circular(12))),
          
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
           
              Row(
                children: [
                  const Text("send by:"),
                  Text(userName,),
                ],
              ),
                   
              Text(
                message,
                style: TextStyle(color: isMe ? Colors.black : Colors.white),
              ),
            ],
          )
        ),
      ],
    );
  }
}
