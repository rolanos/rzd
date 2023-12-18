import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/features/menu/app_bar.dart';

import '../../core/colors.dart';
import 'bottom_navigation_container.dart';

class MenuScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MenuScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUI.mainScaffoldColor,
      bottomNavigationBar: BottomNavigationContainer(
        navigationShell: widget.navigationShell,
      ),
      body: widget.navigationShell,
    );
  }
}
