import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/snack_bar.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';

import 'widget/otp_input.dart';
//import 'package:sms_autofill/sms_autofill.dart';

class AcceptOtpScreen extends StatefulWidget {
  final String? phone;
  AcceptOtpScreen({super.key, this.phone});

  @override
  State<AcceptOtpScreen> createState() => _AcceptOtpScreenState();
}

class _AcceptOtpScreenState extends State<AcceptOtpScreen> {
  final TextEditingController _fieldOne = TextEditingController();

  final TextEditingController _fieldTwo = TextEditingController();

  final TextEditingController _fieldThree = TextEditingController();

  final TextEditingController _fieldFour = TextEditingController();

  Timer? timer;
  int time = 30;

  void startTimer() {
    time = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpChecked) {
          context.goNamed('create_user');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
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
                  "Введите код из смс",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpInput(
                    _fieldOne,
                    true,
                    onChange: () => setState(() {}),
                  ), // auto focus
                  const SizedBox(
                    width: 8,
                  ),
                  OtpInput(
                    _fieldTwo,
                    false,
                    onChange: () => setState(() {}),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OtpInput(
                    _fieldThree,
                    false,
                    onChange: () => setState(() {}),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OtpInput(
                    _fieldFour,
                    false,
                    isLast: true,
                    onChange: () => setState(() {}),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  if (time == 0 && widget.phone != null) {
                    BlocProvider.of<AuthBloc>(context).add(
                      SentOtp(
                        phone: widget.phone!,
                      ),
                    );
                    startTimer();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.21),
                  child: AutoSizeText(
                    (time > 0)
                        ? 'Отправить повторно — $time'
                        : 'Отправить повторно',
                    style: const TextStyle(
                      decorationColor: ColorsUI.borderColor,
                      decoration: TextDecoration.underline,
                      color: ColorsUI.borderColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              GestureDetector(
                onTap: () {
                  if (checkOtpInput(
                      _fieldOne, _fieldTwo, _fieldThree, _fieldFour)) {
                    String otp = _fieldOne.text +
                        _fieldTwo.text +
                        _fieldThree.text +
                        _fieldFour.text;
                    BlocProvider.of<AuthBloc>(context).add(CheckOtp(otp: otp));
                  } else {
                    context.pop();
                  }
                },
                child: Container(
                  height: 64,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: checkOtpInput(
                            _fieldOne, _fieldTwo, _fieldThree, _fieldFour)
                        ? ColorsUI.activeRed
                        : ColorsUI.inactiveRedLight,
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      checkOtpInput(
                              _fieldOne, _fieldTwo, _fieldThree, _fieldFour)
                          ? 'Далее'
                          : 'Назад',
                      maxLines: 1,
                      style: TextStyle(
                        color: checkOtpInput(
                                _fieldOne, _fieldTwo, _fieldThree, _fieldFour)
                            ? ColorsUI.mainWhite
                            : ColorsUI.activeRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

checkOtpInput(TextEditingController _fieldOne, TextEditingController _fieldTwo,
    TextEditingController _fieldThree, TextEditingController _fieldFour) {
  return _fieldOne.text.isNotEmpty &&
      _fieldTwo.text.isNotEmpty &&
      _fieldThree.text.isNotEmpty &&
      _fieldFour.text.isNotEmpty;
}
