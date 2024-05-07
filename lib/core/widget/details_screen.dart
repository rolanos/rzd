// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:rzd/core/colors.dart';
import 'package:rzd/core/extensions.dart';
import 'package:rzd/features/menu/app_bar.dart';

import '../../features/messages/view/bloc/message_bloc.dart';

class DetailScreenData {
  final DateTime? date;
  final String? title;
  final String? body;
  final bool? isRead;
  final String? subtext;

  final String? appbarTitle;
  final String? status;
  DetailScreenData({
    this.isRead,
    this.date,
    this.title,
    this.body,
    this.status,
    this.appbarTitle,
    this.subtext,
  });
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.data});

  final DetailScreenData data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomNotificationsAppBar(
              appbarText: data.appbarTitle ?? "Уведомление",
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: ColorsUI.mainWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 12),
                        child: Row(
                          children: [
                            if (data.status != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                decoration: BoxDecoration(
                                    color: data.status
                                            ?.getStatusColorContainer() ??
                                        ColorsUI.containerBackground,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    data.status ?? "Нет данных",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          data.status?.getStatusColorText() ??
                                              ColorsUI.borderColor,
                                    ),
                                  ),
                                ),
                              ),
                            if (data.status != null)
                              const SizedBox(
                                width: 10,
                              ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                  color: ColorsUI.containerBackground,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                data.date?.format() ?? "Нет данных",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorsUI.borderColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              data.title ?? "Нет данных",
                              style: const TextStyle(
                                color: ColorsUI.otpBorder,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          if (data.body != null)
                            Flexible(
                              child: Text(
                                data.body!,
                                style: const TextStyle(
                                  color: ColorsUI.otpBorder,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (data.subtext != null)
                        SingleChildScrollView(
                          child: Html(data: data.subtext, style: {
                            "body": Style(
                              padding: HtmlPaddings.all(0),
                              margin: Margins.all(0),
                            )
                          }),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
