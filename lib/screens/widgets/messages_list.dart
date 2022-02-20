import 'package:flutter/material.dart';

import '../../data/chat/models/message.dart';

class MessagesList extends StatelessWidget {
  final List<ChatMessageDto> _messagesList;
  final String _nickname;

  const MessagesList(
      {Key? key,
      required List<ChatMessageDto> messagesList,
      required String nickname})
      : _messagesList = messagesList,
        _nickname = nickname,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _messagesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: _nickname == _messagesList[index].author.name ? Colors.green : Colors.deepPurple,
              child: Text(_messagesList[index].author.name[0]),
            ),
            title: Text(_messagesList[index].author.name),
            subtitle: Text(_messagesList[index].message),
          );
        });
  }
}
