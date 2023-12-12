import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';
import 'package:rzd/features/core/theme.dart';

import 'features/auth/view/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthBloc()..add(InitEvent()),
      child: MaterialApp(
        theme: getTheme(),
        home: const AuthScreen(),
      ),
    );
  }
}
