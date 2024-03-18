part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  final List<Message> messages;

  const MessageInitial({this.messages = const []});
}

class MessageLoading extends MessageState {}

class MessageError extends MessageState {
  final String message;

  const MessageError({required this.message});
}
