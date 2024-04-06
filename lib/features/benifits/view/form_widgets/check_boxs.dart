import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';

class CircleCheckBox extends StatelessWidget {
  const CircleCheckBox(
      {super.key,
      required this.text,
      required this.isChecked,
      required this.onTap,
      this.isRedText = false});
  final String text;
  final bool isChecked;
  final Function onTap;
  final bool? isRedText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.5,
                color: isChecked ? ColorsUI.activeRed : ColorsUI.borderColor,
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? ColorsUI.activeRed : Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ContentText(
            text: text,
            textColor: isRedText == true ? ColorsUI.activeRed : null,
          ),
        ],
      ),
    );
  }
}

class SqareCheckBox extends StatelessWidget {
  const SqareCheckBox(
      {super.key,
      required this.text,
      required this.isChecked,
      required this.onTap,
      this.isRedText = false});
  final String text;
  final bool isChecked;
  final Function onTap;
  final bool isRedText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isChecked ? ColorsUI.activeRed : Colors.transparent,
              border: Border.all(
                width: 1.5,
                color: isChecked ? ColorsUI.activeRed : ColorsUI.borderColor,
              ),
            ),
            child: Center(child: SvgPicture.asset('asset/icons/tick.svg')),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: ContentText(
              text: text,
              textColor: isRedText == true ? ColorsUI.activeRed : null,
            ),
          ),
        ],
      ),
    );
  }
}
