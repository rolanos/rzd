import 'package:flutter/material.dart';
import 'package:rzd/features/core/colors.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:provider/provider.dart';

class TabRow extends StatelessWidget {
  const TabRow({super.key});

  @override
  Widget build(BuildContext context) {
    CustomTabController controller =
        Provider.of<CustomTabController>(context, listen: true);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.goToBenifits(),
            child: TabContainer(
              name: 'Льготы',
              isSelected:
                  controller.category == Category.benefits ? true : false,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () => controller.goToReferences(),
            child: TabContainer(
              name: 'Справки и обращения',
              isSelected:
                  controller.category == Category.references ? true : false,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () => controller.goToHistory(),
            child: TabContainer(
              name: 'История',
              isSelected:
                  controller.category == Category.history ? true : false,
            ),
          ),
          SizedBox(
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

  const TabContainer({super.key, required this.name, required this.isSelected});

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
