import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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
      } else {
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
      } else {
        emit(const ErrorChatState(message: 'Нет подключения к интернету'));
      }
    });

    on<SendGeolocationMessage>((event, emit) async {
      if (await InternetConnectionChecker().hasConnection == true) {
        try {
          LocationPermission permission = await Geolocator.requestPermission();
          if(permission != LocationPermission.denied) {
            Position _position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            var _location = ChatGeolocationDto(
                latitude: _position.latitude, longitude: _position.longitude);
            List<ChatMessageDto> _messageList =
                await _chatRepositoryFirebase.sendGeolocationMessage(
                    nickname: event.nickname,
                    location: _location,
                    message: event.message);
            emit(LoadedChatState(_messageList));
          }else{
            emit(const ErrorChatState(message: 'Разрешения отклонены'));
          }
        } catch (_) {
          emit(const ErrorChatState(message: 'You have error'));
        }
      } else {
        emit(const ErrorChatState(message: 'Нет подключения к интернету'));
      }
    });
  }
}
