import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/enums.dart';
import 'package:rzd/features/home/data/model/card_data.dart';
import 'package:rzd/features/home/data/model/history_data.dart';
import 'package:rzd/features/home/view/bloc/history_bloc.dart';
import 'package:rzd/features/home/view/bloc/privileges_bloc.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:rzd/features/home/view/widget/tab_row.dart';
import 'package:rzd/features/menu/app_bar.dart';

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
  double offset = 0.0;
  CustomTabController? controller;

  bool seeAllPrivileges = false;
  bool seeAllHistory = false;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<CustomTabController>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomScrollView(
          controller: controller!.scrollController,
          slivers: [
            SliverAppBar(
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(
                    42,
                  ),
                ),
              ),
              backgroundColor: ColorsUI.mainScaffoldColor,
              pinned: true,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              expandedHeight: AppBar().preferredSize.height * 2.5 + 8.0 + 16,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                expandedTitleScale: 1,
                title: const Column(
                  children: [
                    Spacer(),
                    TabRow(),
                  ],
                ),
                background: Column(
                  children: [
                    CustomAppBar(
                      appbarText: (state is AuthSuccess &&
                              state.profile.name != null &&
                              state.profile.otch != null)
                          ? "${state.profile.name!} ${state.profile.otch!}"
                          : "",
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BlocBuilder<PrivilegesBloc, PrivilegesState>(
                    builder: (context, state) {
                      return BenifitsCard(
                        key: controller?.benefits,
                        seeAll: seeAllPrivileges,
                        mainTitle: 'Ваши льготы, гарантии и компенсации',
                        secondTitle:
                            'Вы можете воспользоваться этими сервисами',
                        onTap: () => setState(
                            () => seeAllPrivileges = !seeAllPrivileges),
                        cardData: List.generate(
                          countToShow(
                              state.privileges.length, seeAllPrivileges),
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
                    key: controller?.references,
                    removeButton: true,
                    mainTitle: 'Справки и обращения',
                    secondTitle: 'Их вы можете направить в БФ «Почет» online',
                    cardData: [
                      CardData(
                        onTap: () => context.goNamed('order'),
                        title: 'Форма заказа справок',
                        assetPath: 'asset/images/books.png',
                      ),
                      CardData(
                        title:
                            'Обращение в комиссию по благотворительной помощи',
                        assetPath: 'asset/images/pen.png',
                      ),
                      CardData(
                        onTap: () => context.goNamed('bf'),
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
                        key: controller?.history,
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
          ],
        );
      },
    );
  }
}

formatDate(DateTime date) {
  String day = date.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  String month = date.month.toString();
  if (month.length == 1) {
    month = '0$month';
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
