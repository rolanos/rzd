part of 'privilege_bloc.dart';

sealed class PrivilegeState extends Equatable {
  const PrivilegeState();

  @override
  List<Object> get props => [];
}

class PrivilegeEmpty extends PrivilegeState {}

class PrivilegeInitial extends PrivilegeState {
  final PrivilegeInfo privilegeInfo;

  const PrivilegeInitial({required this.privilegeInfo});
}
