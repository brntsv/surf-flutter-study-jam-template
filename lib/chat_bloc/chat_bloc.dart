import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_event.dart';
import 'package:surf_practice_chat_flutter/chat_bloc/chat_state.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/firebase.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepositoryFirebase _chatRepositoryFirebase;

  ChatBloc(
    this._chatRepositoryFirebase,
  ) : super(InitialChatState()) {
    on<GetAllMessages>((event, emit) async {
      var r = await InternetConnectionChecker().hasConnection;
      if (await InternetConnectionChecker().hasConnection == true) {
        try {
          emit(LoadingChatState());
          List<ChatMessageDto> _messageList =
              await _chatRepositoryFirebase.messages;
          emit(LoadedChatState(_messageList));
        } catch (_) {
          emit(const ErrorChatState(message: 'Произошла ошибка'));
        }
      }else{
        emit(const ErrorChatState(message: 'Нет подключения к интернету'));
      }
    });
    on<SendMessage>((event, emit) async {
      if (await InternetConnectionChecker().hasConnection == true) {
        try {
          List<ChatMessageDto> _messageList = await _chatRepositoryFirebase
              .sendMessage(event.nickname, event.message);
          emit(LoadedChatState(_messageList));
        } catch (_) {
          emit(const ErrorChatState(message: 'You have error'));
        }
      }else{
        emit(const ErrorChatState(message: 'Нет подключения к интернету'));
      }
    });
  }
}
