import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';
import 'package:rzd/features/core/colors.dart';
import 'package:rzd/features/core/enums.dart';
import 'package:rzd/features/home/data/model/card_data.dart';
import 'package:rzd/features/home/data/model/history_data.dart';
import 'package:rzd/features/home/view/bloc/history_bloc.dart';
import 'package:rzd/features/home/view/bloc/privileges_bloc.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:rzd/features/home/view/widget/tab_row.dart';

import 'widget/benefits_card.dart';
import 'widget/history_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double preveousOffset = 0.0;
  late CustomTabController controller;

  bool seeAllPrivileges = false;
  bool seeAllHistory = false;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<CustomTabController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.scrollController.addListener(
          () {
            if (controller.scrollController.hasClients) {
              if (controller.scrollController.offset > 100.0 &&
                  preveousOffset < 100.0) {
                setState(() {
                  preveousOffset = controller.scrollController.offset;
                });
              }
              if (controller.scrollController.offset < 100.0 &&
                  preveousOffset > 100.0) {
                setState(() {
                  preveousOffset = controller.scrollController.offset;
                });
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: controller.scrollController,
        physics: BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        child: Column(
          children: [
            if (preveousOffset < 100)
              const SizedBox(
                height: 8.0,
              ),
            if (preveousOffset < 100)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TabRow(),
              ),
            const SizedBox(
              height: 8.0,
            ),
            BlocBuilder<PrivilegesBloc, PrivilegesState>(
              builder: (context, state) {
                return BenifitsCard(
                  key: controller.benefits,
                  seeAll: seeAllPrivileges,
                  mainTitle: 'Ваши льготы, гарантии и компенсации',
                  secondTitle: 'Вы можете воспользоваться этими сервисами',
                  onTap: () =>
                      setState(() => seeAllPrivileges = !seeAllPrivileges),
                  cardData: List.generate(
                    countToShow(state.privileges.length, seeAllPrivileges),
                    (index) => CardData(
                      title: state.privileges[index].description,
                      assetPath: null,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            BenifitsCard(
              key: controller.references,
              mainTitle: 'Справки и обращения',
              secondTitle: 'Их вы можете направить в БФ «Почет» online',
              cardData: [
                CardData(
                  title: 'Форма заказа справок',
                  assetPath: 'asset/images/books.png',
                ),
                CardData(
                  title: 'Обращение в комиссию по благотворительной помощи',
                  assetPath: 'asset/images/pen.png',
                ),
                CardData(
                  title: 'Обращение в БФ Почет',
                  assetPath: 'asset/images/hand.png',
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                return HistoryCard(
                  key: controller.history,
                  seeAll: seeAllHistory,
                  onTap: () => setState(
                    () => seeAllHistory = !seeAllHistory,
                  ),
                  historyData: List.generate(
                    countToShow(state.history.length, seeAllHistory),
                    (index) => HistoryData(
                      date: formatDate(state.history[index].moment),
                      name: state.history[index].subject,
                      iconPath: AppIcon.heart.iconPath,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.22,
            ),
          ],
        ),
      ),
    );
  }
}

formatDate(DateTime date) {
  String day = date.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }
  String month = date.month.toString();
  if (month.length == 1) {
    month = '0' + day;
  }
  return '$day.$month.${date.year}';
}

countToShow(int allCount, bool showAll) {
  if (showAll) {
    return allCount;
  }
  if (allCount > 3) {
    return 3;
  } else {
    return allCount;
  }
}
