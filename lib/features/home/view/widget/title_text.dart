import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        color: ColorsUI.otpBorder,
      ),
    );
  }
}
