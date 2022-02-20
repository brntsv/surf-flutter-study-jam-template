import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_event.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_state.dart';

import 'package:surf_practice_chat_flutter/data/chat/repository/repository.dart';

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
  TextEditingController? _nickController;

  @override
  void initState() {
    super.initState();
    _nickController = TextEditingController();
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
            title: Expanded(
              child: TextField(
                controller: _nickController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Введите ник', border: InputBorder.none),
              ),
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
                return ListView.builder(
                    itemCount: state.messageList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Text(state.messageList[index].author.name[0]),
                        ),
                        title: Text(state.messageList[index].author.name),
                        subtitle: Text(state.messageList[index].message),
                      );
                    });
              }
              return const SizedBox();
            },
          ),
        );
      }),
    );
  }
}
