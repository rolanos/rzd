import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';
import 'package:rzd/core/router.dart';
import 'package:rzd/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:rzd/features/history/view/bloc/appeal_bloc.dart';
import 'package:rzd/features/history/view/bloc/used_privilege_bloc.dart';
import 'package:rzd/features/home/view/bloc/bloc/form_bloc.dart';
import 'package:rzd/features/home/view/bloc/privileges_bloc.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rzd/features/news/view/bloc/new_bloc.dart';
import 'package:rzd/features/profile/view/bloc/faq_bloc.dart';
import 'features/benifits/view/sankur/bloc/rest_objects_bloc.dart';
import 'features/home/view/bloc/bloc/privilege_bloc.dart';
import 'features/home/view/bloc/history_bloc.dart';
import 'features/messages/view/bloc/message_bloc.dart';

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
      create: (context) => CustomTabController(
          scrollController: ScrollController(),
          tabScrollController: ScrollController()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  RestObjectsBloc()..add(GetSankurObjects())),
          BlocProvider(
            create: (BuildContext context) => NewBloc()..add(GetNews()),
          ),
          BlocProvider(
            create: (BuildContext context) => FaqBloc()..add(GetFaqs()),
          ),
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
          BlocProvider(create: (context) => MessageBloc()..add(GetMessages())),
          BlocProvider(
              create: (context) =>
                  UsedPrivilegeBloc()..add(GetUsedPrivilegesEvent())),
          BlocProvider(
              create: (context) => AppealBloc()..add(GetAppealsEvent())),
          BlocProvider(create: (context) => FormBloc()..add(GetForms())),
          BlocProvider(
            create: (context) => PrivilegeBloc(),
          ),
        ],
        child: MaterialApp.router(
          theme: getTheme(),
          localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
          supportedLocales: const [
            Locale('ru', 'RU'),
          ],
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
