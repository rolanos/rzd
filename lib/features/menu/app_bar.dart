import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/home/view/tab_controller.dart';
import 'package:rzd/features/home/view/widget/tab_row.dart';
import 'package:provider/provider.dart';
import 'package:rzd/features/messages/model/message.dart';
import 'package:rzd/features/messages/view/bloc/message_bloc.dart';

class CustomNotificationsAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String appbarText;
  final bool withButton;
  const CustomNotificationsAppBar({
    super.key,
    required this.appbarText,
    this.withButton = false,
  });

  @override
  State<CustomNotificationsAppBar> createState() =>
      _CustomNotificationsAppBarState();

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height * 2.5);
}

class _CustomNotificationsAppBarState extends State<CustomNotificationsAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.vertical(
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
        decoration: const ShapeDecoration(
          color: ColorsUI.mainWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24.0),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            context.canPop() == true
                ? GestureDetector(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    child: Container(
                      height: 18,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: SvgPicture.asset("asset/icons/back_arrow.svg"),
                    ),
                  )
                : SizedBox(),
            const SizedBox(
              width: 22.0,
            ),
            Flexible(
              child: Text(
                widget.appbarText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            if (widget.withButton) const Spacer(),
            if (widget.withButton)
              BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (state is! MessageLoading) {
                        context.read<MessageBloc>().add(TickAllMessages());
                      }
                    },
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: AppBar().preferredSize.height * 0.65),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorsUI.boxLightBorder)),
                      child: const Center(
                        child: Text(
                          "Прочитать все",
                          style: TextStyle(
                            color: ColorsUI.mainText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
      borderRadius: const BorderRadius.vertical(
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
        decoration: const ShapeDecoration(
          color: ColorsUI.mainWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24.0),
            ),
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
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
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        widget.appbarText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontFamily: 'Inter'),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () => context.pushNamed('notifications'),
                          icon:
                              SvgPicture.asset("asset/icons/notification.svg")),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
