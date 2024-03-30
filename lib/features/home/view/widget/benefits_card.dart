import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/home/data/model/card_data.dart';
import 'package:rzd/features/home/view/bloc/bloc/form_bloc.dart';

import 'topic_card.dart';

///Ваши льготы, гарантии и компенсации
class BenifitsCard extends StatelessWidget {
  final String mainTitle;
  final String secondTitle;

  final Function()? onTap;

  final bool? seeAll;
  final bool removeButton;
  final List<CardData>? cardData;

  const BenifitsCard(
      {super.key,
      required this.mainTitle,
      required this.secondTitle,
      this.cardData,
      this.onTap,
      this.seeAll,
      this.removeButton = false});

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
            height: 8.0,
          ),
          Text(
            secondTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: textTheme.bodySmall!
                .copyWith(color: ColorsUI.secondaryText, fontSize: 16.0),
          ),
          if (cardData != null)
            ListView.separated(
              shrinkWrap: true,
              itemCount: cardData!.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: TopicCard(
                  title: cardData![index].title,
                  assetPath: cardData![index].assetPath,
                  onTap: cardData![index].onTap,
                ),
              ),
              separatorBuilder: (context, _) => const SizedBox(
                height: 16.0,
              ),
            ),
          if (cardData == null)
            BlocBuilder<FormBloc, FormBlocState>(
              builder: (context, state) {
                if (state is FormInitial) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.forms.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        context.read<FormBloc>().add(
                            GetFormInfo(formKey: state.forms[index].formKey));
                        context.goNamed('form');
                      },
                      child: TopicCard(
                        title: state.forms[index].formName,
                      ),
                    ),
                    separatorBuilder: (context, _) => const SizedBox(
                      height: 16.0,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          const SizedBox(
            height: 24.0,
          ),
          if (removeButton == false)
            ContainerButton(
              text: seeAll == true ? 'Скрыть' : 'Смотреть все',
              onTap: onTap,
            ),
        ],
      ),
    );
  }
}
