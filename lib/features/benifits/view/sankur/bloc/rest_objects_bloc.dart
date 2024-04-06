import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/benifits/model/sanprof.dart';
import 'package:rzd/features/benifits/repository/sankur_repository.dart';

part 'rest_objects_event.dart';
part 'rest_objects_state.dart';

class RestObjectsBloc extends Bloc<RestObjectsEvent, RestObjectsState> {
  RestObjectsBloc() : super(RestObjectsEmpty()) {
    on<GetSankurObjects>((event, emit) async {
      try {
        final res = await SankurRepository().getSanprofList();
        emit(RestObjectsInitial(sanprofList: res));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
