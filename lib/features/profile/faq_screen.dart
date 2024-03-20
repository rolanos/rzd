import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/menu/app_bar.dart';
import 'package:rzd/features/profile/view/widget/faq_expansion.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            appbarText: 'Ответы на вопросы',
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorsUI.scaffoldColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FaqExpansion(
                    title:
                        'Как сообщить об изменении личных данных (адреса, паспорта, банковских реквизитов и т.д.)?',
                    content: ''),
                FaqExpansion(
                    title:
                        'Какие документы потребуются для постановки на учет?',
                    content: ''' • паспорт
 • трудовая книжка
 • копия выписки из банка с реквизитами
 • СНИЛС
 • удостоверения о наградах (если есть)
 • справка об инвалидности (если есть)
​Документы подаются в службу управления персонала предприятия, из которого пенсионер увольнялся на пенсию.'''),
                FaqExpansion(
                    title:
                        'Нужно ли подтверждать свои данные для получения выплат в БФ «Почет»?',
                    content: ''),
                FaqExpansion(
                    title:
                        'Как подтвердить данные для получения помощи в следующем году?',
                    content: ''),
                FaqExpansion(
                    title: 'Как часто необходимо подтверждать данные?',
                    content: ''),
                FaqExpansion(
                    title:
                        'Кто может встать на учет в Благотворительный фонд «Почет»?',
                    content: ''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
