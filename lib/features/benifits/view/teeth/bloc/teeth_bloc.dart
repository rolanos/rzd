import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/benifits/model/teeth_form.dart';
import 'package:rzd/features/benifits/repository/teeth_repository.dart';

part 'teeth_event.dart';
part 'teeth_state.dart';

class TeethBloc extends Bloc<TeethEvent, TeethState> {
  TeethBloc() : super(TeethEmpty()) {
    on<TeethGet>((event, emit) async {
      try {
        final res = await TeethRepository().getNuzList();
        emit(TeethInitial(services: res));
      } catch (e) {
        log(e.toString());
      }
    });
    on<TeethSend>((event, emit) async {
      try {
        emit(TeethSendLoading());
        await TeethRepository().sendRequest(event.teethForm);
        emit(TeethSended());
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
