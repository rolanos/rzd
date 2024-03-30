import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class ContainerButton extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final String text;
  final Function()? onTap;
  const ContainerButton(
      {super.key,
      this.color,
      this.textColor,
      required this.text,
      this.onTap,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
            color: color ?? ColorsUI.backgroundRed,
            borderRadius: BorderRadius.circular(16.0),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: textColor ?? ColorsUI.activeRed,
                ),
          ),
        ),
      ),
    );
  }
}
