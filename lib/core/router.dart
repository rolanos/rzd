import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/features/auth/view/accept_otp_screen.dart';
import 'package:rzd/features/auth/view/auth_screen.dart';
import 'package:rzd/features/auth/view/create_user.dart';
import 'package:rzd/features/auth/view/register_screen.dart';
import 'package:rzd/features/history/view/history_screen.dart';
import 'package:rzd/features/home/view/home_screen.dart';
import 'package:rzd/features/menu/menu.dart';
import 'package:rzd/features/messages/model/message.dart';
import 'package:rzd/core/widget/details_screen.dart';
import 'package:rzd/features/messages/view/message_screen.dart';
import 'package:rzd/features/profile/view/profile_screen.dart';

GoRouter getRouter(BuildContext context) {
  final GoRouter router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
        routes: [
          GoRoute(
            path: 'register',
            name: 'register',
            builder: (context, state) => const RegisterScreen(),
            routes: [
              GoRoute(
                path: 'accept_otp',
                name: 'accept_otp',
                builder: (context, state) =>
                    AcceptOtpScreen(phone: state.extra as String?),
                routes: [
                  GoRoute(
                    path: 'create_user',
                    name: 'create_user',
                    builder: (context, state) => CreateUserScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
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
                  return const HomeScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                name: 'history',
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) {
                  return const ProfileScreen();
                },
                routes: [
                  GoRoute(
                    path: 'notifications',
                    name: 'notifications',
                    builder: (context, state) => const MessagesScreen(),
                    routes: [
                      GoRoute(
                        path: 'notification',
                        name: 'notification',
                        builder: (context, state) => DetailsScreen(
                          data: state.extra as DetailScreenData,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ],
  );

  return router;
}
