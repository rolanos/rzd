import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/container_button.dart';

class DataTile {
  final String title;
  final String text;

  DataTile({
    required this.title,
    required this.text,
  });
}

class UserDataWidget extends StatefulWidget {
  final bool removeButton;

  final String title;
  final String subTitle;
  final List<DataTile> data;
  const UserDataWidget(
      {super.key,
      required this.data,
      required this.title,
      required this.subTitle,
      this.removeButton = false});

  @override
  State<UserDataWidget> createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  bool seeAll = false;
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
            widget.title,
            style: textTheme.titleSmall!.copyWith(fontFamily: 'Work Sans'),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            widget.subTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: textTheme.bodySmall!
                .copyWith(color: ColorsUI.secondaryText, fontSize: 16.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: (seeAll == false && widget.data.length > 3)
                ? 3
                : widget.data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => UserInfoWidget(
              title: widget.data[index].title,
              text: widget.data[index].text,
            ),
            separatorBuilder: (context, _) => const SizedBox(
              height: 20.0,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          if (seeAll)
            Text(
              'Если вы нашли несоответствие, воспользуйтесь формой обратной связи для внесения правок.',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall!
                  .copyWith(color: ColorsUI.secondaryText, fontSize: 14.0),
            ),
          const SizedBox(
            height: 14.0,
          ),
          if (seeAll)
            Column(
              children: [
                ContainerButton(
                  text: 'Форма обратной связи',
                ),
                const SizedBox(
                  height: 14.0,
                ),
              ],
            ),
          if (widget.removeButton == false)
            ContainerButton(
              text: seeAll == true ? 'Свернуть данные' : 'Посмотреть данные',
              onTap: () => setState(() => seeAll = !seeAll),
            ),
        ],
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  final String title;
  final String text;
  const UserInfoWidget({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorsUI.secondaryText, fontSize: 16.0),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: ColorsUI.containerBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
