import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/home/data/model/app_info.dart';
import 'package:rzd/features/home/data/model/card_data.dart';
import 'package:rzd/features/home/view/bloc/bloc/app_info_bloc.dart';
import 'package:rzd/features/home/view/widget/topic_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UsefulMaterials extends StatelessWidget {
  final String mainTitle;
  final List<CardData> cardData;

  const UsefulMaterials(
      {super.key, required this.cardData, required this.mainTitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24.0),
      width: size.width,
      decoration: const BoxDecoration(
        color: ColorsUI.mainWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            mainTitle,
            style: textTheme.titleSmall!.copyWith(fontFamily: 'Work Sans'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: cardData.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                if (cardData[index].onTap != null) {
                  cardData[index].onTap!();
                }
              },
              child: TopicCard(
                onTap: cardData[index].onTap,
                title: cardData[index].title,
                assetPath: cardData[index].assetPath,
                color: ColorsUI.containerBackground,
              ),
            ),
            separatorBuilder: (context, _) => const SizedBox(
              height: 16.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          BlocBuilder<AppInfoBloc, AppInfoState>(
            builder: (context, state) {
              if (state is AppInfoInitial) {
                return GestureDetector(
                  onTap: () async {
                    await launchUrlString(
                      state.appInfo.personal?.link ?? 'https://www.google.ru/',
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      state.appInfo.personal?.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall!.copyWith(
                        color: ColorsUI.secondaryText,
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsUI.secondaryText,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
