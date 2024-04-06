import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/history/model/privilege.dart';
import 'package:rzd/features/history/repository/used_privilege_repository.dart';

part 'used_privilege_event.dart';
part 'used_privilege_state.dart';

class UsedPrivilegeBloc extends Bloc<UsedPrivilegeEvent, UsedPrivilegeState> {
  UsedPrivilegeRepository privilegeRepository = UsedPrivilegeRepository();
  UsedPrivilegeBloc() : super(UsedPrivilegeInitial()) {
    on<GetUsedPrivilegesEvent>((event, emit) async {
      try {
        emit(UsedPrivilegeLoading());
        final result = await privilegeRepository.getUsedPrivileges();
        emit(UsedPrivilegeInitial(privileges: result));
      } catch (e) {
        log(e.toString());
        emit(UsedPrivilegesError(message: "Ошибка загрузки сообщений"));
      }
    });
  }
}
