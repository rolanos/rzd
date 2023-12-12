part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthNotInited extends AuthState {
  @override
  List<Object?> get props => [];
}

//Начальное значение при инициализации Bloc
class AuthEmpty extends AuthState {
  @override
  List<Object?> get props => [];
}

//Состояние загрузки
class AuthLoading extends AuthState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthErrorLogIn extends AuthState {
  final String message;

  AuthErrorLogIn({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthSuccess extends AuthState {
  final String uuid;
  final String email;
  final String password;

  AuthSuccess(
      {required this.uuid, required this.email, required this.password});

  @override
  List<Object?> get props => [uuid, email, password];
}
