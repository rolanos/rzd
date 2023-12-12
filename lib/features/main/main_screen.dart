import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthEmpty) {
            //TODO поменять потом на нормальный роутер
            Navigator.of(context).pop();
          }
        },
        child: Center(
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
            },
            child: Text(
              "Выйти",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
