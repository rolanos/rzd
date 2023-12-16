import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';
import 'package:rzd/features/core/router.dart';
import 'package:rzd/features/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:rzd/features/home/view/bloc/privileges_bloc.dart';
import 'package:rzd/features/home/view/tab_controller.dart';

import 'features/home/data/repository/privileges_repository_impl.dart';
import 'features/home/view/bloc/history_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = getRouter(context);
    return ChangeNotifierProvider<CustomTabController>(
      create: (context) =>
          CustomTabController(scrollController: ScrollController()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AuthBloc()..add(InitEvent()),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                PrivilegesBloc()..add(GetPrivileges()),
          ),
          BlocProvider(
            create: (BuildContext context) => HistoryBloc()..add(GetHistory()),
          ),
        ],
        child: MaterialApp.router(
          theme: getTheme(),
          routerConfig: router,
        ),
      ),
    );
  }
}
