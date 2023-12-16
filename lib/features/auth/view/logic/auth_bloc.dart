import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/features/auth/data/repository/auth_repository_impl.dart';
import 'package:rzd/features/auth/domain/repository/auth_repository.dart';
import 'package:rzd/features/core/api_error.dart';
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
        final String? uuid =
            await authRepository.login(event.email, event.password);
        if (uuid != null) {
          emit(
            AuthSuccess(
              uuid: uuid,
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
  }
}
