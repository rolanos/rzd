import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class ContainerFilePicker extends StatelessWidget {
  const ContainerFilePicker(
      {super.key,
      this.trailing,
      required this.text,
      this.color,
      this.borderColor,
      this.textColor,
      this.onTap});

  final Widget? trailing;
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Function()? onTap;

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
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 24.0, right: 18.0),
        decoration: BoxDecoration(
            color: color ?? ColorsUI.backgroundRed,
            borderRadius: BorderRadius.circular(16.0),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: textColor ?? ColorsUI.activeRed,
                    ),
              ),
            ),
            const SizedBox(width: 10),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class ContainerButton extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final String text;
  final Function()? onTap;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  const ContainerButton(
      {super.key,
      this.color,
      this.textColor,
      required this.text,
      this.onTap,
      this.borderColor,
      this.height,
      this.textStyle,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        padding: padding ??
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 14),
        decoration: BoxDecoration(
            color: color ?? ColorsUI.backgroundRed,
            borderRadius: BorderRadius.circular(16.0),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: textColor ?? ColorsUI.activeRed,
                    ),
          ),
        ),
      ),
    );
  }
}
