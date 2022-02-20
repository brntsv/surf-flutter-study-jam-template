import 'package:equatable/equatable.dart';

import '../data/chat/models/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class InitialChatState extends ChatState {}

class LoadingChatState extends ChatState {}

class LoadedChatState extends ChatState {
  final List<ChatMessageDto> messageList;

  const LoadedChatState(this.messageList);

  @override
  List<Object> get props => [messageList];
}

class ErrorChatState extends ChatState {
  final String message;

  const ErrorChatState({required this.message});

  @override
  List<Object> get props => [message];
}
