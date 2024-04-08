import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/home/data/repository/support_repository.dart';

part 'support_event.dart';
part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  SupportBloc() : super(SupportEmpty()) {
    on<SupportSend>((event, emit) async {
      try {
        emit(SupportSendLoading());
        await SupportRepository().sendForm(event.topic, event.body, event.doc);
        emit(SupportSended());
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
