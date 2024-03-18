part of 'used_privilege_bloc.dart';

sealed class UsedPrivilegeEvent extends Equatable {
  const UsedPrivilegeEvent();

  @override
  List<Object> get props => [];
}

class GetUsedPrivilegesEvent extends UsedPrivilegeEvent {}
