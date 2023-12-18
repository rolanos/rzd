import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:rzd/features/home/view/widget/tab_row.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String appbarText;
  CustomAppBar({
    super.key,
    required this.appbarText,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height * 2.5);
}

class _CustomAppBarState extends State<CustomAppBar> {
  double preveousOffset = 0.0;
  double offset = 0.0;
  late CustomTabController controller;
  @override
  void initState() {
    super.initState();
    controller = Provider.of<CustomTabController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(24.0),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.only(
            top: AppBar().preferredSize.height,
            left: 20.0,
            right: 20.0,
            bottom: 24.0),
        height: AppBar().preferredSize.height * 2.5,
        width: size.width,
        decoration: ShapeDecoration(
          color: ColorsUI.mainWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24.0),
            ),
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            (offset > 100)
                ? const TabRow()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: SvgPicture.asset("asset/icons/profile.svg"),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        widget.appbarText,
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
      ),
    );
  }
}
