import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_event.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_state.dart';

import 'package:surf_practice_chat_flutter/data/chat/repository/repository.dart';
import 'package:surf_practice_chat_flutter/screens/widgets/messages_list_widget.dart';
import 'package:surf_practice_chat_flutter/screens/widgets/send_message_field_widget.dart';

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
  String _nickname = '';
  IconData _messageIcon = Icons.send;

  @override
  void initState() {
    super.initState();
    _nickController = TextEditingController();
    _messageController = TextEditingController();

    _nickController.addListener(() {
      _nickname = _nickController.text;
      setState(() {

      });
    });
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
      create: (_) => ChatBloc(
        ChatRepositoryFirebase(FirebaseFirestore.instance),
      )..add(const GetAllMessages()),
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
                _messageIcon = Icons.refresh;
                return Stack(
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SendMessageFieldWidget(
                        nickname: _nickController.text,
                        controller: _messageController,
                      ),
                    )
                  ],
                );
              }
              if (state is LoadedChatState) {
                return Column(
                  children: [
                    Expanded(
                      child: MessagesListWidget(
                        messagesList: state.messagesList,
                        nickname: _nickController.text,
                      ),
                    ),
                    SendMessageFieldWidget(
                      nickname: _nickname,
                      controller: _messageController,
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
