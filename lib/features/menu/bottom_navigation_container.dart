import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';

///Кастомный BottomNavigationBar
///[navigationShell] - объект пакета go_router предназначенный для удобной навигации по вкладкам BottomNavigationBar
class BottomNavigationContainer extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationContainer({
    super.key,
    required this.navigationShell,
  });

  @override
  State<BottomNavigationContainer> createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  bool showFullMenu = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 12.0),
      height: 0.07 * size.height,
      decoration: const BoxDecoration(
        color: ColorsUI.mainWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(53, 56, 65, 0.12),
            blurRadius: 27,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.navigationShell.goBranch(0, initialLocation: true);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 19,
                        child: SvgPicture.asset(
                          "asset/icons/home.svg",
                          colorFilter: ColorFilter.mode(
                            (widget.navigationShell.currentIndex == 0)
                                ? ColorsUI.darkText
                                : ColorsUI.lightText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Главная",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: (widget.navigationShell.currentIndex == 0)
                              ? ColorsUI.darkText
                              : ColorsUI.lightText,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.navigationShell.goBranch(1, initialLocation: true);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                        child: SvgPicture.asset(
                          "asset/icons/notify.svg",
                          colorFilter: ColorFilter.mode(
                            (widget.navigationShell.currentIndex == 1)
                                ? ColorsUI.darkText
                                : ColorsUI.lightText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "История",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: (widget.navigationShell.currentIndex == 1)
                              ? ColorsUI.darkText
                              : ColorsUI.lightText,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.navigationShell.goBranch(2, initialLocation: true);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                        child: SvgPicture.asset(
                          "asset/icons/profil.svg",
                          colorFilter: ColorFilter.mode(
                            (widget.navigationShell.currentIndex == 2)
                                ? ColorsUI.darkText
                                : ColorsUI.lightText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Профиль",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: (widget.navigationShell.currentIndex == 2)
                              ? ColorsUI.darkText
                              : ColorsUI.lightText,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
