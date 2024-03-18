part of 'used_privilege_bloc.dart';

sealed class UsedPrivilegeState extends Equatable {
  const UsedPrivilegeState();

  @override
  List<Object> get props => [];
}

class UsedPrivilegeInitial extends UsedPrivilegeState {
  final List<UsedPrivilege> privileges;

  const UsedPrivilegeInitial({this.privileges = const []});
}

class UsedPrivilegesError extends UsedPrivilegeState {
  final String message;

  const UsedPrivilegesError({required this.message});
}
