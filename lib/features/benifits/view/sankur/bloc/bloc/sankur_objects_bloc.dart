import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/benifits/model/sankur_form.dart';
import 'package:rzd/features/benifits/model/sanprof.dart';
import 'package:rzd/features/benifits/repository/sankur_repository.dart';

part 'sankur_objects_event.dart';
part 'sankur_objects_state.dart';

class SankurObjectsBloc extends Bloc<SankurObjectsEvent, SankurObjectsState> {
  SankurObjectsBloc() : super(SankurObjectsEmpty()) {
    on<GetList>((event, emit) async {
      try {
        final result = await SankurRepository().getSanprofList();
        emit(SankurObjectsInitial(objects: result));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
