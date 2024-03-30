import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/home/domain/entity/privilege_info.dart';

class OrderContainer extends StatelessWidget {
  const OrderContainer({super.key, required this.chapter});

  final Chapter chapter;

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
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => OrderPoint(
          title: chapter.items?[index].title ?? "",
          content: chapter.items?[index].description ?? "",
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: chapter.items?.length ?? 0,
      ),
    );
  }
}

class OrderPoint extends StatelessWidget {
  const OrderPoint({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          content,
          style: textTheme.bodySmall?.copyWith(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
