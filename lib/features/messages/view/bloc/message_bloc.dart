import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/messages/model/message.dart';
import 'package:rzd/features/messages/repository/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository messageRepository = MessageRepository();
  MessageBloc() : super(MessageInitial()) {
    on<GetMessages>((event, emit) async {
      try {
        final result = await messageRepository.getMessages();
        emit(MessageInitial(messages: result));
      } catch (e) {
        log(e.toString());
        emit(MessageError(message: "Ошибка загрузки сообщений"));
      }
    });
    on<TickAllMessages>((event, emit) async {
      try {
        emit(MessageLoading());
        await messageRepository.tickAllMessages();
        add(GetMessages());
      } catch (e) {
        log(e.toString());
        emit(MessageError(message: "Ошибка загрузки сообщений"));
      }
    });
  }
}
