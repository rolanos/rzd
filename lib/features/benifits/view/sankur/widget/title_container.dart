import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/add_info_container.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/home/view/bloc/bloc/append_bloc.dart';

class TitleContainerSankur extends StatelessWidget {
  const TitleContainerSankur(
      {super.key,
      this.text,
      this.title,
      this.privilegeName,
      required this.appbarTitle,
      required this.id});
  final String id;
  final String appbarTitle;
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
          if (title == 'Санаторно-курортное оздоровление и отдых' ||
              title == 'Обеспечение бытовым топливом' ||
              title == 'Изготовление и ремонт зубных протезов')
            ContainerButton(
              onTap: () {
                switch (title) {
                  case 'Санаторно-курортное оздоровление и отдых':
                    context.pushNamed('sankur');
                    break;
                  case 'Обеспечение бытовым топливом':
                    context.pushNamed('fuel');
                    break;
                  case 'Изготовление и ремонт зубных протезов':
                    context.pushNamed('teeth');
                    break;
                }
              },
              text: 'Получить услугу',
              textColor: ColorsUI.mainWhite,
              color: ColorsUI.activeRed,
            ),
          if (title == 'Санаторно-курортное оздоровление и отдых' ||
              title == 'Обеспечение бытовым топливом' ||
              title == 'Изготовление и ремонт зубных протезов')
            ContainerButton(
              text: 'Добавить документы',
              onTap: () {
                context.read<AppendBloc>().add(AppendGet(type: id));
                context.pushNamed('append', extra: appbarTitle);
              },
              textColor: ColorsUI.activeRed,
              color: ColorsUI.inactiveRedLight,
            ),
          if (title == 'Санаторно-курортное оздоровление и отдых')
            ContainerButton(
              text: 'Объекты для отдыха',
              onTap: () => context.pushNamed('sankur_list'),
              textColor: ColorsUI.activeRed,
              color: ColorsUI.inactiveRedLight,
            ),
          const AdditionalInfoContainer(),
        ],
      ),
    );
  }
}
