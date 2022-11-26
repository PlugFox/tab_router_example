import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Tab;

import 'inherited_tab_router.dart';
import 'tab.dart';
import 'tab_router_delegate.dart';
import 'tab_router_state.dart';

/// {@template app_router}
/// AppRouter widget
/// {@endtemplate}
class TabRouter extends StatefulWidget {
  /// {@macro app_router}
  const TabRouter({
    required this.builder,
    required this.routes,
    required this.tabs,
    this.notFound,
    super.key,
  });

  final Widget Function(BuildContext context, RouterDelegate<TabRouterState> delegate) builder;
  final Map<String, Widget Function(BuildContext context, String name, Map<String, String> arguments)> routes;
  final Widget Function(BuildContext context, String name, Map<String, String> arguments)? notFound;
  final List<String> tabs;

  @override
  State<TabRouter> createState() => _TabRouterState();
}

class _TabRouterState extends State<TabRouter> {
  late final TabRouterDelegate _delegate = TabRouterDelegate();
  late List<Tab> tabs;

  Widget _screenBuilder(BuildContext context, String name, Map<String, String> arguments) =>
      widget.routes[name]?.call(context, name, arguments) ??
      widget.notFound?.call(context, name, arguments) ??
      ErrorWidget('Route "$name" not found');

  @override
  void initState() {
    super.initState();
    tabs = <Tab>[for (var i = 0; i < widget.tabs.length; i++) Tab(i, widget.tabs[i])];
  }

  @override
  void didUpdateWidget(covariant TabRouter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals<String>(widget.tabs, oldWidget.tabs)) {
      tabs = <Tab>[for (var i = 0; i < widget.tabs.length; i++) Tab(i, widget.tabs[i])];
    }
  }

  @override
  void dispose() {
    _delegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InheritedTabRouter(
        screenBuilder: _screenBuilder,
        tabs: tabs,
        child: widget.builder(context, _delegate),
      );
}
