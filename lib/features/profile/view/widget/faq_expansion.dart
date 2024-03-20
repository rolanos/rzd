import 'package:flutter/material.dart';
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
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorsUI.otpBorder,
          ),
        ),
        children: [
          ListTile(
            title: Text(
              content,
              style: const TextStyle(fontSize: 14, color: ColorsUI.otpBorder),
            ),
          ),
        ],
      ),
    );
  }
}
