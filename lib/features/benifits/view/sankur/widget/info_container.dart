import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/home/domain/entity/privilege_info.dart';

import 'info_expansion.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({super.key, required this.chapters});

  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorsUI.mainWhite,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: chapters.length,
        itemBuilder: (context, index) => InfoExpansion(
          title: chapters[index].title ?? "",
          content: chapters[index].description ?? "",
        ),
      ),
    );
  }
}
