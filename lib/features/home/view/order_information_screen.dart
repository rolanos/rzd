import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/auth/view/widget/input_form.dart';
import 'package:rzd/features/menu/app_bar.dart';

class OrderInformationScreen extends StatefulWidget {
  const OrderInformationScreen({super.key});

  @override
  State<OrderInformationScreen> createState() => _OrderInformationScreenState();
}

class _OrderInformationScreenState extends State<OrderInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomNotificationsAppBar(
            appbarText: 'Форма заказа справки',
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorsUI.mainWhite,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Заполните форму',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ColorsUI.otpBorder,
                    fontSize: 20,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorsUI.containerBackground,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: RichText(
                          text: const TextSpan(
                            text:
                                'Если у Вас возникли вопросы, обратитесь на Горячую линию (ИКЦ) по телефонам ',
                            children: [
                              TextSpan(
                                text: '8 800 775 95 97',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorsUI.otpBorder,
                                ),
                              ),
                              TextSpan(
                                text: ' и ',
                              ),
                              TextSpan(
                                text: '1810',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorsUI.otpBorder,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' (с мобильного телефона). Звонок бесплатный. Режим работы: с 02:00 до 18:00 пн-пт (мск).',
                              ),
                            ],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: ColorsUI.otpBorder,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Тема обращения',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsUI.otpBorder,
                  ),
                ),
                const SizedBox(height: 10),
                InputForm(
                  hintText: '',
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Дата начала',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsUI.otpBorder,
                  ),
                ),
                const SizedBox(height: 10),
                InputForm(
                  hintText: 'Выберите дату',
                  controller: TextEditingController(),
                  textInputType: TextInputType.datetime,
                  validator: DateValidator(),
                  errorText: 'Выберите дату',
                  trailing: GestureDetector(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            locale: const Locale('ru', 'RU'),
                            context: context,
                            firstDate: DateTime(1940),
                            lastDate: DateTime.now());
                        if (date != null) {
                          setState(() {
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
                const SizedBox(height: 20),
                const Text(
                  'Дата окончания',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsUI.otpBorder,
                  ),
                ),
                const SizedBox(height: 10),
                InputForm(
                  hintText: 'Выберите дату',
                  controller: TextEditingController(),
                  textInputType: TextInputType.datetime,
                  validator: DateValidator(),
                  errorText: 'Выберите дату',
                  trailing: GestureDetector(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            locale: const Locale('ru', 'RU'),
                            context: context,
                            firstDate: DateTime(1940),
                            lastDate: DateTime.now());
                        if (date != null) {
                          setState(() {
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
                const SizedBox(height: 20),
                const Text(
                  'Адрес',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsUI.otpBorder,
                  ),
                ),
                const SizedBox(height: 10),
                InputForm(
                  hintText: 'Введите адрес',
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Пример: г. Москва ул.Пушкина 44 кв.83',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: ColorsUI.borderColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const ContainerButton(
                  text: 'Отправить',
                  textColor: ColorsUI.mainWhite,
                  color: ColorsUI.activeRed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
