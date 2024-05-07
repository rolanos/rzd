import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/menu/app_bar.dart';
import 'package:rzd/features/profile/view/bloc/faq_bloc.dart';
import 'package:rzd/features/profile/view/widget/faq_expansion.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNotificationsAppBar(
              appbarText: 'Ответы на вопросы',
              withTopPadding: false,
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
              child: BlocBuilder<FaqBloc, FaqState>(
                builder: (context, state) {
                  if (state is FaqInitial) {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.faqs.length,
                      itemBuilder: (context, index) => FaqExpansion(
                        title: state.faqs[index].question ?? "",
                        content: state.faqs[index].answer ?? "",
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
