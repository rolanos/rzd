import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorsUI.mainWhite, borderRadius: BorderRadius.circular(24)),
      child: child ?? const SizedBox(),
    );
  }
}
