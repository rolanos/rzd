import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class AdditionalInfoContainer extends StatelessWidget {
  const AdditionalInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
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
    );
  }
}
