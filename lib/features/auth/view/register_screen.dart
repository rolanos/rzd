import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/snack_bar.dart';
import 'package:rzd/features/auth/view/widget/accept_row.dart';

import 'logic/auth_bloc.dart';
import 'widget/input_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  //Отчество
  final TextEditingController fathersNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController seriesController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '+7 ');

  bool isActiveButton = false;

  bool firstAgree = false;
  bool secondAgree = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is StatusCheckedSuccessfully) {
          BlocProvider.of<AuthBloc>(context)
              .add(SentOtp(phone: phoneController.text));
        }
        if (state is OtpSented) {
          context.goNamed('accept_otp', extra: phoneController.text);
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
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      FormsList(
                        formKey: formKey,
                        surnameController: surnameController,
                        nameController: nameController,
                        fathersNameController: fathersNameController,
                        birthdayController: birthdayController,
                        dateController: dateController,
                        seriesController: seriesController,
                        phoneController: phoneController,
                        numberController: numberController,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      AccessRow(
                        text:
                            'Вы подтверждаете согласие на обработку персональных данных',
                        isAccepted: firstAgree,
                        onTap: () => setState(() => firstAgree = !firstAgree),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      AccessRow(
                        text: 'Делиться номером телефона',
                        isAccepted: secondAgree,
                        onTap: () => setState(() => secondAgree = !secondAgree),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (state is AuthStatusError)
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            color: ColorsUI.inactiveRedLight,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('asset/icons/secure.svg'),
                                const SizedBox(
                                  width: 8,
                                ),
                                const AutoSizeText(
                                  'Физическое лицо не найдено',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: ColorsUI.activeRed,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState?.validate() == true &&
                              firstAgree &&
                              secondAgree) {
                            BlocProvider.of<AuthBloc>(context).add(
                              CheckUserRegistration(
                                fam: surnameController.text,
                                name: nameController.text,
                                otch: fathersNameController.text,
                                birthday: DateFormat('dd.MM.yyyy')
                                    .parse(birthdayController.text),
                                passSeries: seriesController.text,
                                passNumber: numberController.text,
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
                                    'Далее',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: ColorsUI.textWhite,
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
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class FormsList extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController surnameController;
  final TextEditingController nameController;
  //Отчество
  final TextEditingController fathersNameController;
  final TextEditingController birthdayController;
  final TextEditingController dateController;
  final TextEditingController seriesController;
  final TextEditingController numberController;
  final TextEditingController phoneController;

  FormsList(
      {super.key,
      required this.surnameController,
      required this.nameController,
      required this.fathersNameController,
      required this.birthdayController,
      required this.dateController,
      required this.seriesController,
      required this.numberController,
      required this.phoneController,
      required this.formKey});

  @override
  State<FormsList> createState() => _FormsListState();
}

class _FormsListState extends State<FormsList> {
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '+7 ### ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      initialText: '+7 ',
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          InputForm(
            hintText: 'Фамилия',
            controller: widget.surnameController,
            errorText: 'Укажите фамилию',
            validator: NameValidator(),
          ),
          const SizedBox(
            height: 14.0,
          ),
          InputForm(
            hintText: 'Имя',
            controller: widget.nameController,
            errorText: 'Укажите имя',
            validator: NameValidator(),
          ),
          const SizedBox(
            height: 14.0,
          ),
          InputForm(
            hintText: 'Отчество',
            controller: widget.fathersNameController,
            errorText: 'Укажите отчество',
            validator: NameValidator(),
          ),
          const SizedBox(
            height: 14.0,
          ),
          InputForm(
            hintText: 'Дата рождения',
            controller: widget.birthdayController,
            textInputType: TextInputType.datetime,
            validator: DateValidator(),
            errorText: 'Укажите дату рождения',
            trailing: GestureDetector(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      locale: const Locale('ru', 'RU'),
                      context: context,
                      firstDate: DateTime(1940),
                      lastDate: DateTime.now());
                  if (date != null) {
                    setState(() {
                      widget.birthdayController.text =
                          DateFormat('dd.MM.yyyy').format(date);
                    });
                  }
                },
                child: SvgPicture.asset('asset/icons/calendar_2.svg')),
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              DateTextFormatter(),
            ],
          ),
          const SizedBox(
            height: 14.0,
          ),
          InputForm(
            hintText: 'Серия паспорта',
            controller: widget.seriesController,
            textInputType: TextInputType.number,
            errorText: 'Укажите серию паспорта',
            validator: PasportSeriesValidator(),
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
            ],
          ),
          const SizedBox(
            height: 14.0,
          ),
          InputForm(
            hintText: 'Номер паспорта',
            controller: widget.numberController,
            textInputType: TextInputType.number,
            errorText: 'Укажите номер паспорта',
            validator: PasportNumberValidator(),
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
            ],
          ),
          const SizedBox(
            height: 14.0,
          ),
          InputForm(
            hintText: 'Номер телефона',
            controller: widget.phoneController,
            textInputType: TextInputType.phone,
            errorText: 'Укажите номер телефона',
            validator: NameValidator(),
            inputFormatters: [
              maskFormatter,
            ],
          ),
        ],
      ),
    );
  }
}
