import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat_bloc/chat_bloc.dart';
import '../../chat_bloc/chat_event.dart';

class SendMessageFieldWidget extends StatefulWidget {
  final String _nickname;
  final TextEditingController _messageController;

  const SendMessageFieldWidget(
      {Key? key,
      required String nickname,
      required TextEditingController controller})
      : _nickname = nickname,
        _messageController = controller,
        super(key: key);

  @override
  State<SendMessageFieldWidget> createState() => _SendMessageFieldWidgetState();
}

class _SendMessageFieldWidgetState extends State<SendMessageFieldWidget> {
  bool isButtonTap = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: widget._messageController,
              decoration: const InputDecoration(
                  hintText: 'Сообщение',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (widget._nickname.isNotEmpty &&
                widget._messageController.text.isNotEmpty) {
              setState(() {
                isButtonTap = true;
              });
              BlocProvider.of<ChatBloc>(context).add(SendMessage(
                  nickname: widget._nickname,
                  message: widget._messageController.text));
              widget._messageController.clear();
              setState(() {
                isButtonTap = false;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Вы ввели не все данные'),
              ));
            }
          },
          icon: isButtonTap
              ? const CircularProgressIndicator()
              : const Icon(Icons.send),
        )
      ]),
    );
  }
}
