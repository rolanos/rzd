import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rzd/core/colors.dart';

class FaqExpansion extends StatelessWidget {
  const FaqExpansion({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: SizedBox(),
        tilePadding: EdgeInsets.only(left: 8.0),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 10,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorsUI.otpBorder,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SvgPicture.asset('asset/icons/arrow_bottom.svg'),
            ),
          ],
        ),
        children: [
          ListTile(
            title: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: ColorsUI.otpBorder,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
