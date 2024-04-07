import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rzd/features/benifits/model/fuel_form.dart';
import 'package:rzd/features/benifits/repository/fuel_repository.dart';

part 'fuel_event.dart';
part 'fuel_state.dart';

class FuelBloc extends Bloc<FuelEvent, FuelState> {
  FuelBloc() : super(FuelEmpty()) {
    on<FuelSend>((event, emit) async {
      try {
        emit(FuelSendLoading());
        await FuelRepository().sendRequest(event.fuelForm);
        emit(FuelSended());
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
