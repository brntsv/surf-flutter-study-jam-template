import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
// import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:surf_practice_chat_flutter/services/location.dart';
import 'package:surf_practice_chat_flutter/theme.dart';
import 'package:surf_practice_chat_flutter/ui/model/chat_model.dart';
import 'package:surf_practice_chat_flutter/ui/widgets/chat/header/header.dart';
import 'package:surf_practice_chat_flutter/ui/widgets/chat/running_text.dart';
import 'package:surf_practice_chat_flutter/utils.dart';

/// Chat screen templete. This is your starting point.
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String username = '';
  String messageText = '';

  @override
  void initState() {
    // ????????????
    // messages = widget.chatRepository.messages;
    // ????????????
    // final provider = context.read<ChatModel>();
    // provider.getMessages();
    super.initState();
  }

  // Future<dynamic> getLocation() async {
  //   setState(() {
  //     showSpinner = true;
  //   });
  //   Location location = Location();
  //   await location.getCurrentLocation();
  //   print(location.latitude);
  //   print(location.longitude);
  //   ChatGeolocationDto geo = ChatGeolocationDto(
  //       latitude: location.latitude, longitude: location.longitude);

  //   try {
  //     await widget.chatRepository.sendGeolocationMessage(
  //       nickname: 'Don Kek',
  //       location: geo,
  //     );
  //     // https://www.google.ru/maps/@${location.latitude},${location.longitude}
  //   } catch (e) {
  //     print(e);
  //   }
  //   getMessages();
  // }

  @override
  Widget build(BuildContext context) {
    final height = context.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backGradient,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  width: 20,
                  height: height,
                  child: const RunningText(
                    text: Constants.runningText,
                    scrollAxis: Axis.vertical,
                    textStyle: TxtStyle.runningLine,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  width: 20,
                  height: height,
                  child: const RunningText(
                    scrollAxis: Axis.vertical,
                    text: Constants.runningText,
                    textStyle: TxtStyle.runningLine,
                  ),
                ),
              ),
              SafeArea(
                  child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: const [HeaderBar(text: 'MESSAGES')],
                  ),
                ),
              ))
            ],
          )),
    );
  }
}

// class MessageBubble extends StatelessWidget {
//   const MessageBubble({
//     Key? key,
//     required this.author,
//     required this.text,
//     required this.isMe,
//     this.isGeo = false,
//   }) : super(key: key);

//   final String author;
//   final String text;
//   final bool isMe;
//   final bool isGeo;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
//       child: Row(
//         children: [
//           Chip(
//             label: Text(author, style: const TextStyle(fontSize: 14)),
//             backgroundColor: Colors.white,
//             side: const BorderSide(width: 1.0, color: Color(0xFFD0EDF2)),
//             avatar: CircleAvatar(
//               backgroundColor: Color(
//                       (author.hashCode.toInt() / 1000000000 * 0xFFFFFF).toInt())
//                   .withOpacity(1.0),
//               child: Text(
//                 author.toUpperCase().substring(0, 1),
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//           const SizedBox(width: 5),
//           Expanded(
//             child: Material(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//                 bottomRight: Radius.circular(16),
//               ),
//               color: isMe
//                   ? const Color(0xFF3E9AAA).withOpacity(0.25)
//                   : const Color(0xFFC3B47A).withOpacity(0.25),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Text(text, style: const TextStyle(fontSize: 14)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
