import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/home/data/model/append.dart';
import 'package:rzd/features/home/data/repository/append_repository.dart';

part 'append_event.dart';
part 'append_state.dart';

class AppendBloc extends Bloc<AppendEvent, AppendState> {
  AppendBloc() : super(AppendEmpty()) {
    on<AppendGet>((event, emit) async {
      try {
        final list = await AppendRepository().getAppendList();
        emit(AppendInitital(appends: list));
      } catch (e) {
        log(e.toString());
      }
    });
    on<AppendSend>((event, emit) async {
      try {
        emit(AppendSendLoading());
        await AppendRepository()
            .sendRequest(event.id, event.comment, event.file);
        emit(AppendSended());
        add(AppendGet());
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
