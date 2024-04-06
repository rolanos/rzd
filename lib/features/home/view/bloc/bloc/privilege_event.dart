part of 'privilege_bloc.dart';

sealed class PrivilegeEvent {
  const PrivilegeEvent();
}

class GetPrivilegeInfo extends PrivilegeEvent {
  final String type;

  const GetPrivilegeInfo({required this.type});
}
