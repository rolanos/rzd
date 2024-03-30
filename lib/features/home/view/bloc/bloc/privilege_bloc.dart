import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/home/data/repository/privileges_repository_impl.dart';
import 'package:rzd/features/home/domain/entity/privilege_info.dart';

part 'privilege_event.dart';
part 'privilege_state.dart';

class PrivilegeBloc extends Bloc<PrivilegeEvent, PrivilegeState> {
  PrivilegeBloc() : super(PrivilegeEmpty()) {
    on<GetPrivilegeInfo>((event, emit) async {
      try {
        final res =
            await PrivilegesRepositoryImpl().getPrivilegeInfo(event.type);
        if (res != null) emit(PrivilegeInitial(privilegeInfo: res));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
