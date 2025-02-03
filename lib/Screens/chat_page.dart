import 'package:chat_app/Cubit/chat_page/chat_page_cubit.dart';
import 'package:chat_app/Widget/receiver_chat_bubble.dart';
import 'package:chat_app/Widget/sender_chat_bubble.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  ChatPage({super.key});
  List<Message> messageList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              height: 50,
              "assets/images/scholar.png",
            ),
            const Text(
              "Chat",
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'pacifico'),
            ),
          ],
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatPageCubit, ChatPageState>(
              builder: (context, state) {
                messageList =
                    BlocProvider.of<ChatPageCubit>(context).messageList;

                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: BlocProvider.of<ChatPageCubit>(context)
                      .messageList
                      .length, // Directly use state.messageList
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? SenderChatBubble(
                            message: messageList[index],
                            time: messageList[index].createdAt,
                          )
                        : ReceiverChatBubble(
                            message: messageList[index],
                            time: messageList[index].createdAt,
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
              left: 25,
              right: 25,
              top: 10,
            ),
            child: TextField(
              controller: textController,
              onSubmitted: (value) {
                BlocProvider.of<ChatPageCubit>(context)
                    .sendMessage(message: value, email: email.toString());
                textController.clear();
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: const Icon(
                  Icons.send_rounded,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
          )
        ],
      ),
    );
    //       } else {
    //         const CircularProgressIndicator(
    //           color: kPrimaryColor,
    //           strokeWidth: 22,
    //         );
    //       }
    //       return Container();
    //     },
    //   );
  }
}
