import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

import 'user_data_widget.dart';

class BankDataWidget extends StatefulWidget {
  final String title;
  final List<DataTile> data;
  const BankDataWidget({
    super.key,
    required this.data,
    required this.title,
  });

  @override
  State<BankDataWidget> createState() => _BankDataWidgetState();
}

class _BankDataWidgetState extends State<BankDataWidget> {
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
            height: 20.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
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
        ],
      ),
    );
  }
}
