import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/features/benifits/view/sankur/widget/order_container.dart';
import 'package:rzd/features/home/view/bloc/bloc/privilege_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

import 'widget/info_container.dart';
import 'widget/title_container.dart';
import 'widget/warning_container.dart';

class PrivilegeScreen extends StatelessWidget {
  const PrivilegeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivilegeBloc, PrivilegeState>(
      builder: (context, state) {
        if (state is PrivilegeInitial) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 32),
            child: Wrap(
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                const CustomNotificationsAppBar(appbarText: "Услуга"),
                TitleContainerSankur(
                  text: state.privilegeInfo.chapters.firstOrNull?.description ??
                      '',
                  title: state.privilegeInfo.title,
                ),
                InfoContainer(chapters: [
                  ...state.privilegeInfo.chapters
                      .sublist(1, state.privilegeInfo.chapters.length - 2)
                ]),
                //WarningContainer(),
                OrderContainer(
                  chapter: state.privilegeInfo.chapters.last,
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
