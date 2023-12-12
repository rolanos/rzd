import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rzd/features/core/colors.dart';

customSnackBar(BuildContext context, final String text, {Color? color}) {
  Size size = MediaQuery.of(context).size;
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: ColorsUI.textWhite,
    margin: EdgeInsets.only(
        left: size.width * 0.25,
        right: size.width * 0.25,
        bottom: size.height * 0.1),
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: AutoSizeText(
          text,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorsUI.activeRed),
        ),
      ),
    ),
  );
}
