import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/details_screen.dart';
import 'package:rzd/core/widget/message_card.dart';
import 'package:rzd/features/history/view/bloc/appeal_bloc.dart';
import 'package:rzd/features/history/view/bloc/used_privilege_bloc.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:rzd/features/home/view/widget/tab_row.dart';
import 'package:rzd/features/menu/app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ///0 - Обращения, 1 - Льготы
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: ScrollController(),
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
          expandedHeight: 8 + 32 + 32 + 28,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            expandedTitleScale: 1,
            title: Column(
              children: [
                const Spacer(),
                TabRowHistory(
                  isAppeals: selectedIndex == 0,
                  changeFirst: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  changeSecond: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
              ],
            ),
            background: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top / 2,
                ),
                const CustomNotificationsAppBar(
                    withTopPadding: false, appbarText: 'История'),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                if (selectedIndex == 0)
                  BlocBuilder<AppealBloc, AppealState>(
                    builder: (context, state) {
                      if (state is AppealInitial) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: state.appeals.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) => MessageCard(
                            data: DetailScreenData(
                              appbarTitle: 'Обращение',
                              status: state.appeals[index].state,
                              date: state.appeals[index].moment,
                              title: state.appeals[index].subject,
                              body: state.appeals[index].comment,
                              subtext: state.appeals[index].application,
                            ),
                          ),
                        );
                      }
                      if (state is AppealLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorsUI.activeRed,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                if (selectedIndex == 1)
                  BlocBuilder<UsedPrivilegeBloc, UsedPrivilegeState>(
                    builder: (context, state) {
                      if (state is UsedPrivilegeInitial) {
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: state.privileges.length,
                          itemBuilder: (context, index) => MessageCard(
                            data: DetailScreenData(
                              appbarTitle: 'Ваша заявка',
                              date: state.privileges[index].date,
                              title: state.privileges[index].privelegesType,
                              body: state.privileges[index].description,
                            ),
                          ),
                        );
                      }
                      if (state is UsedPrivilegeLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorsUI.activeRed,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
