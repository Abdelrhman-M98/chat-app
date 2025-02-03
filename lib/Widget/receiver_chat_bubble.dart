import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiverChatBubble extends StatelessWidget {
  ReceiverChatBubble({super.key, required this.message, required this.time});
  Message message;
  DateTime time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Color(0xff006d84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            )),
        child: Column(
          children: [
            Text(
              message.data,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              width: 70,
              child: Text(
                DateFormat('h:mm a').format(time),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
