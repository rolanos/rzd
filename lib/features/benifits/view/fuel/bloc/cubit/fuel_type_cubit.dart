import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/benifits/repository/fuel_repository.dart';

part 'fuel_type_state.dart';

class FuelTypeCubit extends Cubit<FuelTypeState> {
  FuelTypeCubit() : super(FuelTypeEmpty());

  getFuelTypes() async {
    try {
      final fuels = await FuelRepository().getFuelTypeList();

      Map<String, dynamic> combinedMap = {};
      for (var map in fuels) {
        if (map.fuel != null) {
          combinedMap = {...combinedMap, ...map.fuel!};
        }
      }
      Map<int, String> result = {};
      for (var i = 0; i < combinedMap.length; i++) {
        result[int.parse(combinedMap.keys.toList()[i])] =
            combinedMap.values.toList()[i] as String;
      }
      emit(FuelTypeInitial(fuels: result));
    } catch (e) {
      log(e.toString());
    }
  }
}
