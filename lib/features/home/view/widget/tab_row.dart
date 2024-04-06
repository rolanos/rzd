import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:provider/provider.dart';

class TabRow extends StatelessWidget {
  const TabRow({super.key});

  @override
  Widget build(BuildContext context) {
    CustomTabController controller =
        Provider.of<CustomTabController>(context, listen: true);
    return SingleChildScrollView(
      controller: controller.tabScrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.only(
          left: 8.0,
        ),
        margin: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => controller.goToBenifits(),
              child: TabContainer(
                key: controller.benefitsTab,
                name: 'Льготы',
                isSelected:
                    controller.category == Category.benefits ? true : false,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            GestureDetector(
              onTap: () => controller.goToReferences(),
              child: TabContainer(
                key: controller.referencesTab,
                name: 'Справки и обращения',
                isSelected:
                    controller.category == Category.references ? true : false,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            GestureDetector(
              onTap: () => controller.goToFaqs(),
              child: TabContainer(
                key: controller.faqTab,
                name: 'Ответы на вопросы',
                isSelected: controller.category == Category.faq ? true : false,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            GestureDetector(
              onTap: () => controller.goToNews(),
              child: TabContainer(
                key: controller.newsTab,
                name: 'Новости и события',
                isSelected: controller.category == Category.news ? true : false,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}

class TabRowHistory extends StatelessWidget {
  const TabRowHistory({
    required this.isAppeals,
    super.key,
    required this.changeFirst,
    required this.changeSecond,
  });

  final bool isAppeals;
  final Function() changeFirst;
  final Function() changeSecond;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                changeFirst();
              },
              child: TabContainer(
                name: 'Обращения',
                isSelected: isAppeals,
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                changeSecond();
              },
              child: TabContainer(
                name: 'Льготы',
                isSelected: !isAppeals,
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }
}

class TabContainer extends StatefulWidget {
  final String name;
  final bool isSelected;

  const TabContainer({
    super.key,
    required this.name,
    required this.isSelected,
  });

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: widget.isSelected ? ColorsUI.darkText : ColorsUI.mainWhite,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Text(
          widget.name,
          style: TextStyle(
            color: widget.isSelected ? ColorsUI.mainWhite : ColorsUI.darkText,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
