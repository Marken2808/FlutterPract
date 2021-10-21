import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tolo/auth/auth_repository.dart';
import 'package:tolo/model/message.dart';

class MessageRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> enterMessage({required Message message}) async {
    try {
      await _firestore.collection('messages').add(message.toMap());
    } catch (e) {
      print(e);
      throw e;
    }
  }
}