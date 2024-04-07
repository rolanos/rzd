import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/home/data/model/app_info.dart';
import 'package:rzd/features/home/data/repository/app_info_repository.dart';

part 'app_info_event.dart';
part 'app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent, AppInfoState> {
  AppInfoBloc() : super(AppInfoEmpty()) {
    on<GetInfo>((event, emit) async {
      try {
        final res = await AppInfoRepository().getInfo();
        if (res != null) {
          emit(AppInfoInitial(appInfo: res));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
