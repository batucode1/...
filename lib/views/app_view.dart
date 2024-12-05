import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateTextStyle.resolveWith((state) {
            if (state.contains(WidgetState.selected)) {
              return TextStyle(color: Theme.of(context).colorScheme.primary);
            } else {
              return TextStyle(color: Theme.of(context).colorScheme.tertiary);
            }
          }),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          indicatorColor: Colors.transparent,
          destinations: [
            _menuItem(context,
                index: 0,
                currentIndex: navigationShell.currentIndex,
                label: 'Karakterler',
                icon: Icons.face),
            _menuItem(context,
                index: 1,
                currentIndex: navigationShell.currentIndex,
                label: 'Favoriler',
                icon: Icons.bookmark),
            _menuItem(context,
                index: 2,
                currentIndex: navigationShell.currentIndex,
                label: 'Konumlar',
                icon: Icons.location_on),
            _menuItem(context,
                index: 3,
                currentIndex: navigationShell.currentIndex,
                label: 'Bölümler',
                icon: Icons.menu),
          ],
        ),
      ),
      body: navigationShell,
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required int index,
    required currentIndex,
    required String label,
    required IconData icon,
  }) {
    return NavigationDestination(
        icon: Icon(
          icon,
          color: currentIndex == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.tertiary,
        ),
        label: label);
  }
}
