import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String data;
  DateTime createdAt;
  final String id;
  Message(this.createdAt, {required this.id, required this.data});

  factory Message.fromJson(jsonData) {
    return Message(
        data: jsonData[kMessage],
        (jsonData[KCreatedAt] as Timestamp).toDate(),
        id: jsonData[KAccountId]);
  }
}
