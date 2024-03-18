import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/widget/details_screen.dart';
import 'package:rzd/features/menu/app_bar.dart';
import 'package:rzd/core/widget/message_card.dart';

import 'bloc/message_bloc.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const CustomNotificationsAppBar(
                appbarText: "Уведомления",
                withButton: true,
              ),
              const SizedBox(
                height: 10,
              ),
              if (state is MessageInitial)
                ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return MessageCard(
                        data: DetailScreenData(
                          appbarTitle: 'Уведомление',
                          isRead: state.messages[index].isRead,
                          title: state.messages[index].subject,
                          body: state.messages[index].body,
                          date: state.messages[index].timestamp,
                        ),
                      );
                    }),
            ],
          ),
        );
      },
    );
  }
}
