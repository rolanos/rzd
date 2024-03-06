import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/snack_bar.dart';

import 'logic/auth_bloc.dart';
import 'widget/input_form.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //Отчество
  final TextEditingController rePasswordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.goNamed('home');
        }
      },
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AutoSizeText(
                    "Заполните ваши данные",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                //Input forms
                BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                  if (state is AuthSuccess) {
                    context.goNamed('home');
                  }
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        context,
                        state.message,
                        color: ColorsUI.activeRed,
                      ),
                    );
                  }
                }, builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        InputForm(
                          hintText: 'Логин',
                          controller: loginController,
                          errorText: 'Укажите желаемый логин',
                          validator: NameValidator(),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        InputForm(
                          hintText: 'Пароль',
                          controller: passwordController,
                          errorText: 'Укажите пароль',
                          validator: NameValidator(),
                          obscureText: obscurePassword,
                          trailing: GestureDetector(
                            onTap: () => setState(() {
                              obscurePassword = !obscurePassword;
                            }),
                            child: SvgPicture.asset(obscurePassword
                                ? 'asset/icons/obscure.svg'
                                : 'asset/icons/obscure_off.svg'),
                          ),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        InputForm(
                          hintText: 'Повторите пароль',
                          controller: rePasswordController,
                          errorText: 'Укажите пароль',
                          obscureText: true,
                          validator: NameValidator(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState?.validate() == true) {
                              BlocProvider.of<AuthBloc>(context).add(
                                RegisterEvent(
                                  login: loginController.text,
                                  password: passwordController.text,
                                  rePassword: rePasswordController.text,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 64,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            decoration: BoxDecoration(
                              color: ColorsUI.activeRed,
                              borderRadius: BorderRadius.circular(
                                16.0,
                              ),
                            ),
                            child: Center(
                              child: (state is! AuthLoading)
                                  ? const AutoSizeText(
                                      'Зарегистрироваться',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: ColorsUI.mainWhite,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const CircularProgressIndicator(
                                      color: ColorsUI.mainWhite,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool checkValidation(
  GlobalKey<FormState> surname,
  GlobalKey<FormState> name,
  GlobalKey<FormState> fathersName,
  GlobalKey<FormState> birthday,
  GlobalKey<FormState> pasportSeries,
  GlobalKey<FormState> pasportNumber,
) {
  if (surname.currentState?.validate() == true &&
      name.currentState?.validate() == true &&
      fathersName.currentState?.validate() == true &&
      birthday.currentState?.validate() == true &&
      pasportSeries.currentState?.validate() == true &&
      pasportNumber.currentState?.validate() == true) {
    return true;
  }
  return false;
}
