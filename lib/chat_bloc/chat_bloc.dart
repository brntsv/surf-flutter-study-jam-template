import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_event.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_state.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/firebase.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepositoryFirebase _chatRepositoryFirebase;

  ChatBloc(this._chatRepositoryFirebase) : super(InitialChatState()) {
    on<GetAllMessages>((event, emit) async {
      try {
        emit(LoadingChatState());
        List<ChatMessageDto> _messageList =
            await _chatRepositoryFirebase.messages;
        emit(LoadedChatState(_messageList));
      } catch (_) {
        emit(const ErrorChatState(message: 'You have error'));
      }
    });
    on<SendMessage>((event, emit) async {
      try {
       // emit(LoadingChatState());
        List<ChatMessageDto> _messageList = await _chatRepositoryFirebase
            .sendMessage(event.nickname, event.message);
        emit(LoadedChatState(_messageList));
      } catch (_) {
        emit(const ErrorChatState(message: 'You have error'));
      }
    });
  }
}
