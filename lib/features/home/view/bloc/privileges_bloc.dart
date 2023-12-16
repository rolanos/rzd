import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/home/data/repository/privileges_repository_impl.dart';
import 'package:rzd/features/home/domain/entity/privileges.dart';

part 'privileges_event.dart';
part 'privileges_state.dart';

class PrivilegesBloc extends Bloc<PrivilegesEvent, PrivilegesState> {
  PrivilegesRepositoryImpl repositoryImpl = PrivilegesRepositoryImpl();
  PrivilegesBloc() : super(PrivilegesState()) {
    on<GetPrivileges>((event, emit) async {
      try {
        final privileges = await repositoryImpl.getPrivileges();
        emit(PrivilegesState(privileges: privileges));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
