import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/theme.dart';
import 'package:surf_practice_chat_flutter/ui/model/chat_model.dart';

class UsernameField extends StatefulWidget {
  const UsernameField({Key? key}) : super(key: key);

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  String username = '';
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatModel>();
    final model = context.read<ChatModel>();

    return Row(
      children: [
        Expanded(
          child: username.isNotEmpty
              ? Text(
                  username,
                  style: TxtStyle.content14Red.copyWith(fontSize: 25),
                )
              : TextField(
                  controller: provider.nameTextController,
                  onEditingComplete: () {
                    final name = model.nameTextController.value.text;
                    if (name.isNotEmpty) {
                      setState(() => username = name);
                    }
                  },
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      hintText: 'ВВЕДИТЕ НИК',
                      hintStyle: TxtStyle.blender20Blue),
                ),
        ),
        IconButton(
          onPressed: () => model.getMessages(),
          icon: const Icon(
            Icons.refresh,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
