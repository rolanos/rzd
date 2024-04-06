part of 'privilege_bloc.dart';

sealed class PrivilegeState {
  const PrivilegeState();
}

class PrivilegeEmpty extends PrivilegeState {}

class PrivilegeInitial extends PrivilegeState {
  final PrivilegeInfo privilegeInfo;

  const PrivilegeInitial({required this.privilegeInfo});
}
