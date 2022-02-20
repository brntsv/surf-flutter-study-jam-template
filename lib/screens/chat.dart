import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_event.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_state.dart';

import 'package:surf_practice_chat_flutter/data/chat/repository/repository.dart';
import 'package:surf_practice_chat_flutter/screens/widgets/messages_list.dart';

import '../chat_bloc/chat_bloc.dart';
import '../data/chat/repository/firebase.dart';

/// Chat screen templete. This is your starting point.
class ChatScreen extends StatefulWidget {
  final ChatRepository chatRepository;

  const ChatScreen({
    Key? key,
    required this.chatRepository,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _nickController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _nickController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nickController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(task): Use ChatRepository to implement the chat.
    // throw UnimplementedError();
    return BlocProvider(
      create: (_) =>
          ChatBloc(ChatRepositoryFirebase(FirebaseFirestore.instance))
            ..add(const GetAllMessages()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _nickController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: 'Введите ник', border: InputBorder.none),
            ),
            actions: [
              IconButton(
                  onPressed: () =>
                      context.read<ChatBloc>().add(const GetAllMessages()),
                  icon: const Icon(Icons.refresh))
            ],
          ),
          body: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is LoadingChatState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is LoadedChatState) {
                return Column(
                  children: [
                    Expanded(
                        child: MessagesList(messagesList: state.messagesList, nickname: _nickController.text,)),
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                  hintText: 'Сообщение',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_nickController.text.isNotEmpty &&
                                _messageController.text.isNotEmpty) {
                              context.read<ChatBloc>().add(SendMessage(
                                  nickname: _nickController.text,
                                  message: _messageController.text));
                              _messageController.clear();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Вы ввели не все данные'),
                              ));
                            }
                          },
                          icon: const Icon(Icons.send),
                        )
                      ]),
                    )
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        );
      }),
    );
  }
}
