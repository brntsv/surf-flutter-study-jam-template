import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}


class GetAllMessages extends ChatEvent{
  const GetAllMessages();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent{
  final String nickname;
  final String message;
  const SendMessage({required this.nickname, required this.message});

  @override
  List<Object> get props => [nickname, message];
}