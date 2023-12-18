import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/features/auth/view/auth_screen.dart';
import 'package:rzd/features/home/view/home_screen.dart';
import 'package:rzd/features/menu/menu.dart';

GoRouter getRouter(BuildContext context) {
  final GoRouter router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MenuScreen(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) {
                  return HomeScreen();
                },
              ),
            ],
          )
        ],
      ),
    ],
  );

  return router;
}
