import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Tab;

import 'information_parser.dart';
import 'information_provider.dart';
import 'inherited_tab_router.dart';
import 'logging.dart';
import 'tab_route_state.dart';
import 'tab_router_delegate.dart';

/// {@template tab_router_builder}
/// AppRouter widget
/// {@endtemplate}
class TabRouterBuilder extends StatefulWidget {
  /// {@macro tab_router_builder}
  const TabRouterBuilder({
    required this.routerBuilder,
    required this.tabsBuilder,
    required this.pageBuilder,
    required this.tabs,
    this.debugLogDiagnostics,
    this.initialLocation,
    super.key,
  });

  final String? initialLocation;

  /// This callback used for building [WidgetsApp.router]
  final Widget Function(BuildContext context, RouterConfig<TabRouteState> config) routerBuilder;

  /// This callback used for building root with tabs
  /// [tabs] - list of tabs
  /// [currentTab] - current tab
  /// [body] - navigation stack
  final Widget Function(BuildContext context, List<String> tabs, String? currentTab, Widget body) tabsBuilder;

  /// This callback used for building every page
  final Page Function(BuildContext context, String name, Map<String, String> arguments) pageBuilder;

  /// List of tabs
  final List<String> tabs;

  /// Debug log diagnostics
  final bool? debugLogDiagnostics;

  @override
  State<TabRouterBuilder> createState() => _TabRouterBuilderState();
}

class _TabRouterBuilderState extends State<TabRouterBuilder> with _TabRouterBuilderDebugLogDiagnostics {
  late final TabRouterDelegate _delegate = TabRouterDelegate();
  late final TabRouteInformationProvider _routeInformationProvider = TabRouteInformationProvider(
    initialLocation: widget.initialLocation,
    //refreshListenable: ,
  );
  final BackButtonDispatcher backButtonDispatcher = RootBackButtonDispatcher();

  late final _routeInformationParser = TabRouteInformationParser();

  late final RouterConfig<TabRouteState> _config = RouterConfig<TabRouteState>(
    routerDelegate: _delegate,
    routeInformationProvider: _routeInformationProvider,
    routeInformationParser: _routeInformationParser,
    backButtonDispatcher: backButtonDispatcher,
  );

  @override
  void dispose() {
    _delegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InheritedTabRouter(
        pageBuilder: widget.pageBuilder,
        tabs: widget.tabs,
        child: Builder(builder: (context) => widget.routerBuilder(context, _config)),
      );
}

mixin _TabRouterBuilderDebugLogDiagnostics on State<TabRouterBuilder> {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('debugLogDiagnostics', value: widget.debugLogDiagnostics, ifTrue: 'enabled'));
  }

  @override
  void initState() {
    $setLogging(enabled: widget.debugLogDiagnostics);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabRouterBuilder oldWidget) {
    $setLogging(enabled: widget.debugLogDiagnostics);
    super.didUpdateWidget(oldWidget);
  }
}
