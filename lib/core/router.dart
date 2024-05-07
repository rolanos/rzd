import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/features/auth/view/accept_otp_screen.dart';
import 'package:rzd/features/auth/view/auth_screen.dart';
import 'package:rzd/features/auth/view/create_user.dart';
import 'package:rzd/features/auth/view/register_screen.dart';
import 'package:rzd/features/benifits/view/fuel/fuel_screen.dart';
import 'package:rzd/features/benifits/view/privilege_screen.dart';
import 'package:rzd/features/benifits/view/sankur/sankur_obj_screen.dart';
import 'package:rzd/features/benifits/view/sankur/sankur_screen.dart';
import 'package:rzd/features/benifits/view/teeth/teeth_screen.dart';
import 'package:rzd/features/documents/view/documents_screen.dart';
import 'package:rzd/features/history/view/history_screen.dart';
import 'package:rzd/features/home/view/appeal_bf_screen.dart';
import 'package:rzd/features/home/view/append_screen.dart';
import 'package:rzd/features/home/view/form_screen.dart';
import 'package:rzd/features/home/view/home_screen.dart';
import 'package:rzd/features/home/view/support_screen.dart';
import 'package:rzd/features/menu/menu.dart';
import 'package:rzd/core/widget/details_screen.dart';
import 'package:rzd/features/messages/view/message_screen.dart';
import 'package:rzd/features/news/model/new_info.dart';
import 'package:rzd/features/news/view/new_screen.dart';
import 'package:rzd/features/profile/view/faq_screen.dart';
import 'package:rzd/features/profile/view/profile_screen.dart';

import '../features/home/view/financial_assistance_screen.dart';

GoRouter getRouter(BuildContext context) {
  final GoRouter router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/sankur_list',
        name: 'sankur_list',
        builder: (context, state) => const SankurObjectsScreen(),
      ),
      GoRoute(
        path: '/docs',
        name: 'docs',
        builder: (context, state) => const DocumentsScreen(),
      ),
      GoRoute(
        path: '/append',
        name: 'append',
        builder: (context, state) => AppendScreen(
          appBarTitle: state.extra as String,
        ),
      ),
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
                    builder: (context, state) => const CreateUserScreen(),
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
                routes: [
                  GoRoute(
                    path: 'form',
                    name: 'form',
                    builder: (context, state) => const FormScreen(),
                  ),
                  GoRoute(
                    path: 'bf',
                    name: 'bf',
                    builder: (context, state) => const AppealBfScreen(),
                  ),
                  GoRoute(
                    path: 'mat',
                    name: 'mat',
                    builder: (context, state) =>
                        const FinansialAssistanceScreen(),
                  ),
                  GoRoute(
                    path: 'privilege',
                    name: 'privilege',
                    builder: (context, state) => PrivilegeScreen(
                      type: (state.extra as String?) ?? '',
                    ),
                    routes: [
                      GoRoute(
                        path: 'sankur',
                        name: 'sankur',
                        builder: (context, state) => const SankurScreen(),
                      ),
                      GoRoute(
                        path: 'fuel',
                        name: 'fuel',
                        builder: (context, state) => const FuelScreen(),
                      ),
                      GoRoute(
                        path: 'teeth',
                        name: 'teeth',
                        builder: (context, state) => const TeethScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'news',
                    name: 'news',
                    builder: (context, state) => NewScreen(
                      newInfo: state.extra as NewInfo,
                    ),
                  ),
                ],
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
                  GoRoute(
                    path: 'faq',
                    name: 'faq',
                    builder: (context, state) => const FaqScreen(),
                  ),
                  GoRoute(
                    path: 'support',
                    name: 'support',
                    builder: (context, state) => const SupportScreen(),
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
