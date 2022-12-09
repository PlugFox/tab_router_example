import 'package:flutter/widgets.dart';

import 'named_route_settings.dart';
import 'tab_route_state.dart';
import 'tab_router_delegate.dart';

/// {@template app_router}
/// AppRouter widget
/// {@endtemplate}
class AppRouter extends InheritedWidget with _AppRouterNavigation {
  /// {@macro app_router}
  const AppRouter({
    required this.controller,
    required super.child,
    super.key,
  });

  @override
  final RouterController controller;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `AppRouter.maybeOf(context)`
  static AppRouter? maybeOf(BuildContext context) =>
      context.getElementForInheritedWidgetOfExactType<AppRouter>()?.widget as AppRouter?;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a AppRouter of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `AppRouter.of(context)`
  static AppRouter of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(AppRouter oldWidget) => false;
}

mixin _AppRouterNavigation on InheritedWidget {
  static Never _notFound() => throw ArgumentError('Not found', 'not_found');

  abstract final RouterController controller;

  NavigatorState get navigator => controller.navigator ?? _notFound();

  TabRouteState get state => controller.value;

  void reset() => controller.setState(TabRouteState.empty());

  void nav(TabRouteState Function(TabRouteState state) change) => controller.setState(change(state));

  void navTab(
    List<RouteSettings> Function(List<NamedRouteSettings> routes) change, {
    String? tab,
    bool activate = false,
  }) {
    final targetTab = tab ?? state.tabs.current;
    if (targetTab == null) {
      assert(false, 'No tab to navigate to');
      return;
    }
    controller.setState(
      state.copyWith(
        newTabs: state.tabs.copyWith(
          newCurrent: activate ? tab : state.tabs.current,
          newPages: <String, List<RouteSettings>>{
            ...state.tabs,
            targetTab: change(state.tabs[targetTab] ?? <NamedRouteSettings>[]),
          },
        ),
      ),
    );
  }

  void push(String name, {Map<String, String>? arguments}) => nav(
        (state) => state.copyWith(
          newPages: state.pages.copyWith(
            newPages: [
              ...state.pages,
              RouteSettings(name: name, arguments: arguments),
            ],
          ),
        ),
      );

  /// Push a new page to the current tab (or [tab] if specified)
  /// If [activate] is true, the tab will be activated
  void pushTab(String name, {Map<String, String>? arguments, String? tab, bool activate = false}) => nav(
        (state) {
          final targetTab = tab ?? state.tabs.current;
          if (targetTab == null) {
            return state.copyWith(
              newPages: state.pages.copyWith(
                newPages: [
                  ...state.pages,
                  RouteSettings(name: name, arguments: arguments),
                ],
              ),
            );
          }
          return state.copyWith(
            newTabs: state.tabs.copyWith(
              newCurrent: activate ? tab : state.tabs.current,
              newPages: <String, List<RouteSettings>>{
                ...state.tabs,
                targetTab: <RouteSettings>[
                  ...?state.tabs[targetTab],
                  RouteSettings(name: name, arguments: arguments),
                ],
              },
            ),
          );
        },
      );

  void activateTab(String tab) => nav((state) => state.copyWith(newTabs: state.tabs.copyWith(newCurrent: tab)));

  //void pop() => throw UnimplementedError();

  //void popTab({Map<String, String>? arguments, String? tab, bool activate = false}) => throw UnimplementedError();
}
