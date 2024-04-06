import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class MainTitleText extends StatelessWidget {
  const MainTitleText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: ColorsUI.mainText,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class SubTitleText extends StatelessWidget {
  const SubTitleText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: ColorsUI.mainText,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  final String text;
  final Color? textColor;
  const ContentText({super.key, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor ?? ColorsUI.mainText,
        fontSize: 14,
      ),
    );
  }
}
