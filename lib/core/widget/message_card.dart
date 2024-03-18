import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/messages/model/message.dart';

import 'details_screen.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.data});

  final DetailScreenData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        'notification',
        extra: data,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ColorsUI.mainWhite,
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (data.status != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                        color: data.status?.getStatusColorContainer() ??
                            ColorsUI.containerBackground,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        data.status ?? "Нет данных",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: data.status?.getStatusColorText() ??
                              ColorsUI.borderColor,
                        ),
                      ),
                    ),
                  ),
                if (data.status != null) const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                      color: ColorsUI.containerBackground,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      data.date?.format() ?? "Нет данных",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorsUI.borderColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                if (data.isRead == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: SvgPicture.asset(
                      "asset/icons/arrow_right.svg",
                      width: 5,
                      height: 12,
                    ),
                  ),
                if (data.isRead == false)
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: ColorsUI.activeRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    data.title ?? "Пусто",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ColorsUI.otpBorder,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
