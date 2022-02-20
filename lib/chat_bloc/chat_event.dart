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
  const SendMessage();

  @override
  List<Object> get props => [];
}