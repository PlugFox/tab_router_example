import 'package:flutter/material.dart';
import 'package:tab_router/tab_router.dart';

import '../../feature/product/widget/product_scope.dart';
import '../router/routes.dart';
import 'material_scope.dart';
import 'tabs_screen.dart';

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => ProductScope(
        child: TabRouterBuilder(
          tabs: Tabs.values.map<String>((e) => e.name).toList(),
          routerBuilder: _routerBuilder,
          pageBuilder: _pageBuilder,
          tabsBuilder: _tabsBuilder,
        ),
      );

  static Widget _routerBuilder(
    BuildContext context,
    RouterConfig<TabRouteState> config,
    RouterController controller,
  ) =>
      MaterialScope(routerConfig: config, controller: controller);

  static Page<Object?> _pageBuilder(
    BuildContext context,
    String name,
    Map<String, String> arguments,
  ) =>
      $routes[name]!(context, arguments);

  static Widget _tabsBuilder(
    BuildContext context,
    List<String> tabs,
    String? currentTab,
    Widget body,
  ) =>
      TabsScreen(tabs: tabs, currentTab: currentTab, body: body);
}
