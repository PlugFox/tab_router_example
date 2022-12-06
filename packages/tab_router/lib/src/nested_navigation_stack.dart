import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'inherited_tab_router.dart';
import 'utils.dart';

/// {@template nested_navigation_stack}
/// NestedNavigationStack widget
/// {@endtemplate}
class NestedNavigationStack extends StatefulWidget {
  /// {@macro nested_navigation_stack}
  const NestedNavigationStack({
    required this.tab,
    required this.active,
    required this.routes,
    super.key,
  });

  final String tab;
  final bool active;
  final List<RouteSettings> routes;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _NestedNavigationStackState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_NestedNavigationStackState>();

  @override
  State<NestedNavigationStack> createState() => _NestedNavigationStackState();
}

/// State for widget NestedNavigationStack
class _NestedNavigationStackState extends State<NestedNavigationStack> {
  Iterable<Page<Object?>> _buildPages(BuildContext context) sync* {
    final inhTabRouter = InheritedTabRouter.of(context, listen: false);
    final routes = widget.routes;
    yield inhTabRouter.pageBuilder(context, widget.tab, <String, String>{'active': widget.active ? 'true' : 'false'});
    for (final route in routes) {
      final name = route.name;
      final arguments = route.arguments;
      if (name == null || name.isEmpty) return;
      if (arguments == null || arguments is! Map<String, String>) return;
      yield inhTabRouter.pageBuilder(
        context,
        RouterUtils.safeRouteName(name),
        RouterUtils.safeRouteArguments(arguments),
      );
    }
  }

  bool _onPopPage(Route<Object?> route, Object? result) {
    if (!route.didPop(result)) return false;
    final controller = InheritedTabRouter.of(context, listen: false).controller;
    final state = controller.value;
    final tabs = state.tabs;
    final routes = tabs[widget.tab];
    if (routes == null || routes.isEmpty) return false;
    controller.setState(
      state.copyWith(
        newTabs: tabs.copyWith(
          newPages: <String, List<RouteSettings>>{
            ...tabs,
            widget.tab: routes.sublist(0, routes.length - 1),
          },
        ),
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print('NestedNavigationStack.build: ${widget.tab} ${widget.active} ${widget.routes.length} routes');
    final pages = _buildPages(context).toList(growable: false);
    return Navigator(
      pages: pages,
      /* observers: <NavigatorObserver>[
          _modalRouteAnalyticsObserver,
        ], */
      onPopPage: _onPopPage,
    );
  }
}
