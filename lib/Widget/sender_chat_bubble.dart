import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderChatBubble extends StatelessWidget {
  SenderChatBubble({super.key, required this.message, required this.Time});
  Message message;
  DateTime Time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: Column(
          children: [
            Text(
              message.Data,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              width: 70,
              child: Text(
                DateFormat('h:mm a').format(Time),
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
