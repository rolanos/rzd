part of 'privilege_bloc.dart';

sealed class PrivilegeEvent extends Equatable {
  const PrivilegeEvent();

  @override
  List<Object> get props => [];
}

class GetPrivilegeInfo extends PrivilegeEvent {
  final String type;

  const GetPrivilegeInfo({required this.type});
}
