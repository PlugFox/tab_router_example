import 'package:flutter/material.dart';

/// {@template tabs_screen}
/// TabsScreen widget
/// {@endtemplate}
class TabsScreen extends StatelessWidget {
  /// {@macro tabs_screen}
  const TabsScreen({
    required this.currentTab,
    required this.tabs,
    required this.body,
    super.key,
  });

  final String? currentTab;
  final List<String> tabs;
  final Widget body;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _calculateSelectedIndex(context),
          onTap: (int idx) => _onItemTapped(idx, context),
        ),
      );

  static int _calculateSelectedIndex(BuildContext context) {
    switch ('unknown') {
      case 'favorite':
        return 0;
      case 'shop':
        return 1;
      case 'settings':
        return 2;
      default:
        return 1;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
  }
}
