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
class TabsStack extends StatefulWidget {
  /// {@macro tabs_stack}
  const TabsStack({
    required this.tabsState,
    super.key,
  });

  final TabsSettings? tabsState;

  @override
  State<TabsStack> createState() => _TabsStackState();
}

class _TabsStackState extends State<TabsStack> {
  @override
  void initState() {
    print('TabsStack.initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabsStack oldWidget) {
    print('TabsStack.didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final tabs = InheritedTabRouter.of(context, listen: true).tabs;
    final currentTab = widget.tabsState?.current;
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
              routes: widget.tabsState?[tab] ?? const <RouteSettings>[],
            ),
          )
          .toList(growable: false),
    );
  }
}
