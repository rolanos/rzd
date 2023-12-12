// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';

import 'package:rzd/features/auth/view/widget/input_form.dart';
import 'package:rzd/features/core/colors.dart';
import 'package:rzd/features/core/widget/snack_bar.dart';
import 'package:rzd/features/main/main_screen.dart';

///Экран авторизации
class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isActiveButton = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      emailController.addListener(
        () {
          if (emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty) {
            setState(() {
              isActiveButton = true;
            });
          }
          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
            setState(() {
              isActiveButton = false;
            });
          }
        },
      );
      passwordController.addListener(
        () {
          if (emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty) {
            setState(() {
              isActiveButton = true;
            });
          }
          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
            setState(() {
              isActiveButton = false;
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }
        if (state is AuthErrorLogIn) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              context,
              state.message,
              color: ColorsUI.activeRed,
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.0 + AppBar().preferredSize.height,
              ),
              Image.asset(
                "asset/images/logo.png",
                width: size.width * 0.216,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                child: AutoSizeText(
                  "Сервисный портал пенсионера ОАО «РЖД»",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: size.height * 0.054,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                child: AutoSizeText(
                  "Войти в аккаунт",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              //Input forms
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      InputForm(
                        hintText: 'Почта',
                        controller: emailController,
                        color: ColorsUI.containerLightGrey,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      InputForm(
                        hintText: 'Пароль',
                        controller: passwordController,
                        color: ColorsUI.containerLightGrey,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isActiveButton) {
                            BlocProvider.of<AuthBloc>(context).add(
                              LogInEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            color: isActiveButton
                                ? ColorsUI.activeRed
                                : ColorsUI.inactiveRed,
                            borderRadius: BorderRadius.circular(
                              16.0,
                            ),
                          ),
                          child: Center(
                            child: (state is! AuthLoading)
                                ? const AutoSizeText(
                                    'Войти',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: ColorsUI.textWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : const CircularProgressIndicator(
                                    color: ColorsUI.textWhite,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
