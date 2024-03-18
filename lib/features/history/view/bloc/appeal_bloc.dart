import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/history/model/appeal.dart';
import 'package:rzd/features/history/repository/appeal_repository.dart';

part 'appeal_event.dart';
part 'appeal_state.dart';

class AppealBloc extends Bloc<AppealEvent, AppealState> {
  AppealRepository appealRepository = AppealRepository();
  AppealBloc() : super(AppealInitial()) {
    on<GetAppealsEvent>((event, emit) async {
      try {
        final result = await appealRepository.getAppeals();
        emit(AppealInitial(appeals: result));
      } catch (e) {
        log(e.toString());
        emit(MessageError(message: "Ошибка загрузки сообщений"));
      }
    });
  }
}
