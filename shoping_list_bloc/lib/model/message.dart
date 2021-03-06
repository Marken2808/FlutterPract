import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? sender;
  final String text;
  final bool? isLiked;
  final bool? seen;
  final Timestamp? time;

  Message({
    this.sender,
    required this.text,
    this.time,
    this.isLiked,
    this.seen,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'isLiked': isLiked,
      'seen': seen,
      'time': Timestamp.fromDate(DateTime.now()),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'],
      text: map['text'],
      isLiked: map['isLiked'],
      seen: map['seen'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
