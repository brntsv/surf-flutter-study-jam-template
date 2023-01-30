import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/ui/theme/theme.dart';

class ChatCard extends StatelessWidget {
  final String? userAvatar;
  final String? name;
  final String? message;
  final bool isMe;
  final VoidCallback onTap;
  const ChatCard({
    Key? key,
    this.userAvatar,
    this.name,
    this.message,
    this.isMe = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      CircleAvatar(
        backgroundColor:
            isMe ? const Color(0xFFC2890E) : AppColors.backGradientBegin,
        child: Text(
          name?[0].toUpperCase() ?? 'U',
          style: TxtStyle.content14Red.copyWith(color: AppColors.textBlue),
        ),
      ),
      const SizedBox(width: 5),
      Flexible(
        fit: FlexFit.tight,
        child: Container(
          decoration: BoxDecoration(
              color: isMe ? Colors.transparent : AppColors.backGradientBegin,
              border: Border.all(
                  color: isMe ? const Color(0xFFF5BB1C) : AppColors.red,
                  width: 1.2),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  name ?? 'ИМЯ НЕИЗВЕСТНО',
                  textAlign: TextAlign.left,
                  style:
                      isMe ? TxtStyle.content20Orange : TxtStyle.content20Blue,
                ),
              ),
              if (message != null) const SizedBox(height: 5),
              if (message != null)
                Text(
                  message ?? '',
                  textAlign: TextAlign.left,
                  style:
                      isMe ? TxtStyle.content14Orange : TxtStyle.content14Blue,
                ),
              // location != null
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           const Icon(Icons.place, size: 17),
              //           TextButton(
              //             style: TextButton.styleFrom(
              //               minimumSize: Size.zero,
              //               padding: EdgeInsets.zero,
              //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //             ),
              //             onPressed: () {
              //               MapsLauncher.launchCoordinates(
              //                   location!.location.latitude,
              //                   location!.location.longitude);
              //             },
              //             child: const Text(
              //               'Открыть в картах',
              //             ),
              //           ),
              //           const Spacer(),
              //         ],
              //       )
              //     : const SizedBox.shrink(),
            ],
          ),
        ),
      )
    ];
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200, minHeight: 40.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isMe ? children.reversed.toList() : children,
      ),
    );
  }
}
