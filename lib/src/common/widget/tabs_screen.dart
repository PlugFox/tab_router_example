import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/routes.dart';

/// {@template tabs_screen}
/// TabsScreen widget
/// {@endtemplate}
class TabsScreen extends StatelessWidget {
  /// {@macro tabs_screen}
  const TabsScreen({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: child,
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
    final segment = GoRouterState.of(context).uri.pathSegments.first.toLowerCase();
    switch (segment) {
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
        GoRouter.of(context).goFavorite();
        break;
      case 1:
        GoRouter.of(context).goShop();
        break;
      case 2:
        GoRouter.of(context).goSettings();
        break;
    }
  }
}
