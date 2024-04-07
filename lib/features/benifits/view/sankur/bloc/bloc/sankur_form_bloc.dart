import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/benifits/model/sankur_form.dart';
import 'package:rzd/features/benifits/repository/sankur_repository.dart';

part 'sankur_form_event.dart';
part 'sankur_form_state.dart';

class SankurFormBloc extends Bloc<SankurFormEvent, SankurFormState> {
  SankurFormBloc() : super(SankurFormInitial()) {
    on<SankurSend>((event, emit) async {
      try {
        emit(SankurSendLoading());
        await SankurRepository().sendRequest(event.sankurForm);
        emit(SankurSended());
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
