import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/theme/theme.dart';

class FieldWithButton extends StatelessWidget {
  const FieldWithButton(
      {Key? key,
      required this.controller,
      this.onIconTap,
      this.hintText,
      this.messageInProgress = false,
      this.icon,
      this.onEditingComplete})
      : super(key: key);
  final TextEditingController controller;
  final VoidCallback? onIconTap;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  final IconData? icon;
  final bool messageInProgress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onEditingComplete: onEditingComplete,
            controller: controller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                hintText: hintText ?? 'СООБЩЕНИЕ',
                hintStyle: TxtStyle.blender20Blue),
          ),
        ),
        messageInProgress
            ? const CircularProgressIndicator(
                color: AppColors.red,
              )
            : IconButton(
                onPressed: onIconTap,
                icon: Icon(
                  icon,
                  color: AppColors.red,
                ))
      ],
    );
  }
}
