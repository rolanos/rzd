import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rzd/core/colors.dart';

class AccessRow extends StatelessWidget {
  final String text;
  final bool isAccepted;
  final Function onTap;
  const AccessRow(
      {super.key,
      required this.text,
      required this.isAccepted,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isAccepted ? ColorsUI.activeRed : Colors.transparent,
              border: isAccepted == false
                  ? Border.all(
                      color: ColorsUI.borderColor,
                      width: 1.5,
                    )
                  : null,
            ),
            child: isAccepted
                ? Center(
                    child: SvgPicture.asset('asset/icons/tick.svg'),
                  )
                : SizedBox(),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
