import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/home/data/repository/history_repository_impl.dart';
import 'package:rzd/features/home/domain/entity/history.dart';
import 'package:rzd/features/home/domain/repository/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryRepository historyRepository = HistoryRepositoryImpl();
  HistoryBloc() : super(HistoryState()) {
    on<GetHistory>((event, emit) async {
      try {
        final history = await historyRepository.getAll();
        emit(HistoryState(history: history));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
