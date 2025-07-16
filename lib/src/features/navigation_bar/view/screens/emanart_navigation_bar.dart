import 'package:emanart/src/core/theme/emanart_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmanArtNavigationBar extends ConsumerStatefulWidget {
  const EmanArtNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<EmanArtNavigationBar> createState() =>
      _EmanArtNavigationBarState();
}

class _EmanArtNavigationBarState extends ConsumerState<EmanArtNavigationBar> {
  int selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // retrieve the theme state
    EmanArtThemeState themeState = ref.watch(emanArtThemeControllerProvider);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeState.secondaryBackgroundColor,
        selectedItemColor: themeState.activeItemColor,
        unselectedItemColor: themeState.textColor,
        currentIndex: selectedIndex,
        iconSize: 30,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          _goToBranch(selectedIndex);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.speed_rounded),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_bolt),
            label: "Power",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: "Temperature",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: "Settings",
          // ),
        ],
      ),
    );
  }
}
