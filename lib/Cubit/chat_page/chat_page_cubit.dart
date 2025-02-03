// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_page_state.dart';

class ChatPageCubit extends Cubit<ChatPageState> {
  ChatPageCubit() : super(ChatPageInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  List<Message> messageList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {
          kMessage: message,
          KCreatedAt: DateTime.now(),
          KAccountId: email,
        },
      );
    } on Exception {
      // May Add Failure state
    }
  }

  void receiveMessage() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatPageSuccess(messageList: messageList));
    });
  }
}
