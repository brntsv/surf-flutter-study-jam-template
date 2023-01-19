import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_chat_flutter/theme.dart';
import 'package:surf_practice_chat_flutter/ui/model/chat_model.dart';
import 'package:surf_practice_chat_flutter/ui/widgets/chat/chat_card.dart';
import 'package:surf_practice_chat_flutter/ui/widgets/chat/field_w_button.dart';
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatModel>().getMessages();
    });
  }

  @override
  void didChangeDependencies() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<ChatModel>().getMessages();
    // });
    super.didChangeDependencies();
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
    final provider = context.watch<ChatModel>();
    final model = context.read<ChatModel>();
    final height = context.height;

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Container(
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
                      children: [
                        const HeaderBar(text: 'xxxxxxx'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: username.isNotEmpty
                                  ? Text(
                                      username,
                                      style: TxtStyle.content14Red
                                          .copyWith(fontSize: 25),
                                    )
                                  : TextField(
                                      controller: provider.nameTextController,
                                      onEditingComplete: () {
                                        final name =
                                            model.nameTextController.value.text;
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
                        ),
                        provider.isMessagesLoading
                            ? const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.msgBrdOrange,
                                  ),
                                ),
                              )
                            : provider.messages == null
                                ? Expanded(
                                    child: Center(
                                      child: Text(
                                        provider.errorMessage ??
                                            'ОШИБКА СЕРВЕРА',
                                        style: TxtStyle.content32Blue,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        reverse: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          final item = provider.messages?[i];
                                          return ChatCard(
                                            isMe: item?.author.name
                                                    .toLowerCase() ==
                                                username.toLowerCase(),
                                            onTap: () {},
                                            name: item?.author.name,
                                            message: item?.message,
                                          );
                                        },
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 20),
                                        itemCount: provider.messages!.length)),
                        const SizedBox(height: 10),
                        FieldWithButton(
                          controller: provider.messageTextController,
                          messageInProgress: provider.isMessageSending,
                          onIconTap: () async {
                            await model.sendMessage();
                          },
                          icon: Icons.send,
                        )
                      ],
                    ),
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
