import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/extensions.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/news/model/new_info.dart';

class NewsContent extends StatelessWidget {
  const NewsContent(
      {super.key, required this.newInfo, this.isHomePage = true, this.onTap});

  final NewInfo newInfo;
  final bool isHomePage;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
        context.goNamed('news', extra: newInfo);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //if (newInfo.image != null) Image.memory(base64Decode(newInfo.image!)),
          if (newInfo.image != null) const SizedBox(height: 12),
          Container(
            padding: isHomePage == false
                ? const EdgeInsets.symmetric(horizontal: 12, vertical: 2)
                : null,
            decoration: isHomePage == false
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsUI.containerBackground)
                : null,
            child: Text(
              newInfo.startDate?.format() ?? "-",
              style: const TextStyle(
                color: ColorsUI.borderColor,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            newInfo.title ?? "-",
            style: const TextStyle(
              color: ColorsUI.mainText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            isHomePage == false
                ? (newInfo.text ?? "-")
                : (newInfo.description ?? "-"),
            style: const TextStyle(
              color: ColorsUI.mainText,
              fontSize: 14,
            ),
          ),
          if (isHomePage)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ContainerButton(
                  text: 'Читать',
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  textColor: ColorsUI.mainText,
                  color: Colors.transparent,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
