part of 'auth_bloc.dart';

abstract class AuthEvent {}

class InitEvent extends AuthEvent {}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  LogInEvent({required this.email, required this.password});
}

class LogOutEvent extends AuthEvent {}

class CheckUserRegistration extends AuthEvent {
  final String fam;
  final String name;
  final String otch;
  final DateTime birthday;
  final String passSeries;
  final String passNumber;

  CheckUserRegistration(
      {required this.fam,
      required this.name,
      required this.otch,
      required this.birthday,
      required this.passSeries,
      required this.passNumber});
}

class RegisterEvent extends AuthEvent {
  final String login;
  final String password;
  final String rePassword;

  RegisterEvent({
    required this.login,
    required this.password,
    required this.rePassword,
  });
}

class SentOtp extends AuthEvent {
  final String phone;

  SentOtp({required this.phone});
}

class CheckOtp extends AuthEvent {
  final String otp;

  CheckOtp({required this.otp});
}
