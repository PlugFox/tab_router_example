import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_router/tab_router.dart';

import '../../feature/favorite/widget/favorite_scope.dart';

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
    final count = FavoriteScope.of(context).length;
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _IconWithBadge(Icons.favorite, badge: count > 0 ? count.toString() : null, size: 24),
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
        onTap: (index) {
          AppRouter.of(context).activateTab(Tabs.values[index].name);
          HapticFeedback.selectionClick().ignore();
        },
      ),
    );
  }
}

class _IconWithBadge extends StatelessWidget {
  const _IconWithBadge(this.icon, {this.badge, this.size = 48});

  final IconData icon;
  final String? badge;
  final double size;

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox.square(
          dimension: size,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Icon(icon, size: size),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: badge == null
                    ? const SizedBox.shrink()
                    : SizedBox.square(
                        key: ValueKey<String>(badge ?? ''),
                        dimension: size / 2,
                        child: Center(
                          child: Text(
                            badge ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontSize: size / 2.5,
                              height: 1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
}
