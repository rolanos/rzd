import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/auth/view/widget/input_form.dart';
import 'package:rzd/features/menu/app_bar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
            appbarText: 'Форма для обратной связи',
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
                  hintText: 'Введите тему',
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Обращение',
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
                  'Документы',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsUI.otpBorder,
                  ),
                ),
                const SizedBox(height: 10),
                const ContainerButton(
                  text: 'Выбрать файлы',
                  color: ColorsUI.inactiveRedLight,
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Flexible(
                      child: Text(
                        '''1. Размер загружаемого файла после сжатия не должен превышать 5 Мб.
2. В имени прикладываемого файла должно быть не более 100 символов.
3. Общее количество загружаемых файлов не должно превышать 3.
4. Общий размер комплекта со всеми вложениями не должен превышать 10 Мб.''',
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
