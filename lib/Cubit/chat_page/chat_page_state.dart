part of 'chat_page_cubit.dart';

@immutable
abstract class ChatPageState {}

class ChatPageInitial extends ChatPageState {}

class ChatPageSuccess extends ChatPageState {
  List<Message> messageList = [];
  ChatPageSuccess({required this.messageList});
}
