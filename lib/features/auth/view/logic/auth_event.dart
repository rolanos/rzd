part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class InitEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  LogInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
