import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:meta/meta.dart';

import 'inherited_tab_router.dart';
import 'nested_navigation_stack.dart';
import 'tabs_pages.dart';

/// {@template tabs_stack}
/// TabsStack widget
/// {@endtemplate}
@internal
class TabsStack extends StatelessWidget {
  /// {@macro tabs_stack}
  const TabsStack({
    required this.tabsState,
    super.key,
  });

  final TabsSettings? tabsState;

  @override
  Widget build(BuildContext context) {
    final tabs = InheritedTabRouter.of(context, listen: true).tabs;
    final currentTab = tabsState?.current;
    final currentIndex = tabs.indexWhere((tab) => tab == currentTab).clamp(0, tabs.length - 1);
    return IndexedStack(
      index: currentIndex,
      sizing: StackFit.expand,
      children: tabs
          .mapIndexed<Widget>(
            (index, tab) => NestedNavigationStack(
              key: ValueKey<String>(tab),
              tab: tab,
              active: currentIndex == index,
              routes: tabsState?[tab] ?? const <RouteSettings>[],
            ),
          )
          .toList(growable: false),
    );
  }
}
