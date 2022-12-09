import 'package:flutter/material.dart';
import 'package:tab_router/tab_router.dart';

enum Tabs with Comparable<Tabs> {
  favorite('Favorite'),
  shop('Shop'),
  settings('Settings');

  const Tabs(this.label);

  final String label;

  @override
  int compareTo(Tabs other) => index.compareTo(other.index);
}

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
  Widget build(BuildContext context) {
    final currentTab = AppRouter.of(context).state.tabs.current;
    final currentIndex = Tabs.values.indexWhere((tab) => tab.name == currentTab).clamp(0, Tabs.values.length - 1);
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: Tabs.favorite.label,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: Tabs.shop.label,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: Tabs.settings.label,
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) => AppRouter.of(context).activateTab(Tabs.values[index].name),
      ),
    );
  }
}
