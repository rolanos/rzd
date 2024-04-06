import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rzd/core/colors.dart';

///Карта с топиком, например "Медицинские услуги"
///[title] - название услуги
///[assetPath] - путь к картинке
class TopicCard extends StatelessWidget {
  final String title;
  final String? assetPath;
  final Function? onTap;
  final Color? color;

  const TopicCard(
      {super.key, required this.title, this.assetPath, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        width: size.width,
        height: size.height * 0.12,
        decoration: BoxDecoration(
          color: color ?? ColorsUI.containerBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (assetPath != null)
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: (assetPath!.substring(assetPath!.length - 3,
                                        assetPath!.length) ==
                                    'png' ||
                                assetPath!.substring(assetPath!.length - 3,
                                        assetPath!.length) ==
                                    'jpg')
                            ? Image.asset(assetPath!)
                            : SvgPicture.string(assetPath!),
                      ),
                    ),
                  ],
                ),
              ),
            Positioned(
              top: 16.0,
              left: 16.0,
              right: size.width * 0.30,
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
