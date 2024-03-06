import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/features/auth/data/repository/auth_repository_impl.dart';
import 'package:rzd/features/auth/domain/entity/user_model.dart';
import 'package:rzd/features/auth/domain/repository/auth_repository.dart';
import 'package:rzd/core/api_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepositoryImpl();
  AuthBloc() : super(AuthNotInited()) {
    on<InitEvent>(
      (event, emit) async {
        emit(AuthLoading());
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final String? email = sharedPreferences.getString("email");
        final String? password = sharedPreferences.getString("password");
        final String? uuid = sharedPreferences.getString("uuid");
        log("uuid - $uuid");
        if (uuid != null && email != null && password != null) {
          add(LogInEvent(email: email, password: password));
        } else {
          emit(AuthEmpty());
        }
      },
    );
    on<LogInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserProfile? profile =
            await authRepository.login(event.email, event.password);
        if (profile != null) {
          emit(
            AuthSuccess(
              profile: profile,
              email: event.email,
              password: event.password,
            ),
          );
        } else {
          emit(AuthErrorLogIn(message: "Ошибка авторизации"));
        }
      } on ApiError catch (e) {
        log(e.message);
        emit(AuthErrorLogIn(message: e.message));
      } catch (e) {
        log(e.toString());
        emit(AuthErrorLogIn(message: "Ошибка авторизации"));
      }
    });
    on<LogOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        String? email = preferences.getString('email');
        String? password = preferences.getString('password');
        if (email != null && password != null) {
          final bool check = await authRepository.logout(email, password);
          if (check == true) {
            emit(
              AuthEmpty(),
            );
          } else {
            emit(AuthErrorLogIn(message: "Ошибка авторизации"));
          }
        }
      } on ApiError catch (e) {
        log(e.message);
        emit(AuthErrorLogIn(message: e.message));
      } catch (e) {
        log(e.toString());
        emit(AuthErrorLogIn(message: "Ошибка авторизации"));
      }
    });
    on<CheckUserRegistration>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.checkStatus(event.fam, event.name, event.otch,
            event.birthday, event.passSeries, event.passNumber);
        emit(StatusCheckedSuccessfully());
      } catch (e) {
        emit(AuthStatusError());
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? uuid = preferences.getString('uuid');
        if (uuid != null) {
          await authRepository.register(
            event.login,
            event.password,
            event.rePassword,
            uuid,
          );
          add(
            LogInEvent(
              email: event.login,
              password: event.password,
            ),
          );
        }
      } catch (e) {
        emit(AuthError(message: 'Ошибка регистрации пользователя'));
      }
    });
    on<SentOtp>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? uuid = preferences.getString('uuid');
      if (uuid != null) {
        try {
          await authRepository.sentOtp(
              uuid, event.phone.replaceAll(' ', '').replaceAll('-', ''));
          emit(OtpSented());
        } catch (e) {
          log(e.toString());
          emit(AuthError(message: 'Произошла ошибка отправки кода'));
        }
      }
    });
    on<CheckOtp>((event, emit) async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? uuid = preferences.getString('uuid');
        if (uuid != null) {
          bool? result = await authRepository.checkOtp(uuid, event.otp);
          if (result == null) {
            emit(AuthError(message: 'Произошла ошибка проверки кода'));
          }
          if (result == true) {
            emit(OtpChecked());
          } else {
            emit(AuthError(message: 'Неправильный код'));
          }
        }
      } catch (e) {
        log(e.toString());
        emit(AuthError(message: 'Произошла ошибка проверки кода'));
      }
    });
  }
}
