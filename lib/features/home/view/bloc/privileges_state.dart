part of 'privileges_bloc.dart';

class PrivilegesState extends Equatable {
  final List<Privileges> privileges;

  PrivilegesState({this.privileges = const []});

  @override
  List<Object?> get props => [privileges];
}
