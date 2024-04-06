import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/add_info_container.dart';
import 'package:rzd/core/widget/container_button.dart';

class TitleContainerSankur extends StatelessWidget {
  const TitleContainerSankur(
      {super.key, this.text, this.title, this.privilegeName});

  final String? title;
  final String? text;
  final String? privilegeName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorsUI.mainWhite,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: Wrap(
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Text(
            title ?? '',
            style: textTheme.titleSmall,
          ),
          Text(
            text ?? '',
            style: textTheme.bodySmall?.copyWith(fontSize: 14),
          ),
          ContainerButton(
            onTap: () {
              if (title == 'Санаторно-курортное оздоровление и отдых')
                context.goNamed('sankur');
            },
            text: 'Получить услугу',
            textColor: ColorsUI.mainWhite,
            color: ColorsUI.activeRed,
          ),
          const ContainerButton(
            text: 'Добавить документы',
            textColor: ColorsUI.activeRed,
            color: ColorsUI.inactiveRedLight,
          ),
          const ContainerButton(
            text: 'Объекты для отдыха',
            textColor: ColorsUI.activeRed,
            color: ColorsUI.inactiveRedLight,
          ),
          const AdditionalInfoContainer(),
        ],
      ),
    );
  }
}
