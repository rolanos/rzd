import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rzd/features/core/colors.dart';

///Карта с топиком, например "Медицинские услуги"
///[title] - название услуги
///[assetPath] - путь к картинке
class TopicCard extends StatelessWidget {
  final String title;
  final String? assetPath;

  const TopicCard({super.key, required this.title, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.12,
      decoration: BoxDecoration(
        color: ColorsUI.containerGrey,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (assetPath != null)
            Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(assetPath!)),
            ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: size.width * 0.30,
            child: AutoSizeText(
              title,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
