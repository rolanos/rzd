import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rzd/features/core/colors.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:rzd/features/home/view/widget/tab_row.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height * 2.5);
}

class _CustomAppBarState extends State<CustomAppBar> {
  double preveousOffset = 0.0;
  late CustomTabController controller;
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
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
          top: AppBar().preferredSize.height,
          left: 20.0,
          right: 20.0,
          bottom: 24.0),
      height: AppBar().preferredSize.height * 2.5,
      width: size.width,
      decoration: const BoxDecoration(
        color: ColorsUI.mainWhite,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24.0),
        ),
      ),
      child: Column(
        children: [
          Spacer(),
          (controller.scrollController.offset > 100)
              ? const TabRow()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage("asset/images/human4.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      "Михаил Иванович",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    SvgPicture.asset("asset/icons/arrow_right_2.svg"),
                  ],
                ),
        ],
      ),
    );
  }
}
