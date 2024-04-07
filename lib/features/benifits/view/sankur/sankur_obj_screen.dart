import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/menu/app_bar.dart';

import 'bloc/bloc/sankur_objects_bloc.dart';

class SankurObjectsScreen extends StatelessWidget {
  const SankurObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNotificationsAppBar(appbarText: 'Объекты для отдыха'),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: MediaQuery.of(context).size.width * 0.3),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(13, 43, 65, 0.1),
                      offset: Offset(0, 4),
                      blurRadius: 14,
                    ),
                  ],
                  color: ColorsUI.mainWhite,
                  borderRadius: BorderRadius.circular(16)),
              child: const Center(child: SubTitleText(text: 'Фильтр')),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            BlocBuilder<SankurObjectsBloc, SankurObjectsState>(
              builder: (context, state) {
                if (state is SankurObjectsInitial) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: ColorsUI.mainWhite,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromRGBO(229, 255, 208, 1),
                            ),
                            child: const ContentText(text: 'ж/д'),
                          ),
                          const SizedBox(height: 10),
                          SubTitleText(
                            text: state.objects[index].name ?? '-',
                          ),
                          const SizedBox(height: 10),
                          ContentText(
                            text: state.objects[index].address ?? '-',
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: state.objects.length,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsUI.activeRed,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
