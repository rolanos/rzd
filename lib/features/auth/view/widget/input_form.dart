import 'package:flutter/material.dart';
import 'package:rzd/features/core/colors.dart';

class InputForm extends StatelessWidget {
  final String? errorText;
  final String hintText;
  final TextEditingController controller;
  final Color color;

  final TextInputType? textInputType;

  final bool? obscureText;

  final TextStyle? inputStyle;

  const InputForm({
    super.key,
    this.errorText,
    required this.hintText,
    required this.controller,
    required this.color,
    this.textInputType,
    this.obscureText,
    this.inputStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 18.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        color: color,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        obscuringCharacter: "●",
        style: inputStyle ?? Theme.of(context).textTheme.bodyMedium,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorsUI.secondaryText),
        ),
      ),
    );
  }
}
