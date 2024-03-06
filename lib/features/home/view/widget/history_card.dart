import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/home/data/model/history_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryCard extends StatelessWidget {
  final List<HistoryData> historyData;

  final Function()? onTap;
  final bool? seeAll;

  const HistoryCard(
      {super.key, required this.historyData, this.onTap, this.seeAll});

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
            "История полученных льгот",
            style: textTheme.titleSmall!.copyWith(fontFamily: 'Work Sans'),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: historyData.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => HistoryDataRow(
              historyData: historyData[index],
            ),
            separatorBuilder: (context, separatedIndex) =>
                (separatedIndex != historyData.length)
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        width: size.width,
                        height: 1.0,
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(226, 232, 240, 1),
                              Color.fromRGBO(226, 232, 240, 0),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ContainerButton(
            text: seeAll == true ? 'Скрыть' : 'Смотреть все',
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class HistoryDataRow extends StatelessWidget {
  final HistoryData historyData;

  const HistoryDataRow({super.key, required this.historyData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: size.width * 0.8,
      height: 60.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 0.117 * size.width,
            height: 0.117 * size.width,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: ColorsUI.containerLightGrey,
            ),
            child: Center(
              child: SvgPicture.asset(historyData.iconPath),
            ),
          ),
          const SizedBox(
            width: 14.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  historyData.date,
                  style: textTheme.bodySmall!.copyWith(
                    color: ColorsUI.secondaryText,
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Expanded(
                  child: Text(
                    historyData.name,
                    maxLines: 2,
                    style: textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SvgPicture.asset(
            "asset/icons/arrow_right.svg",
          ),
        ],
      ),
    );
  }
}
