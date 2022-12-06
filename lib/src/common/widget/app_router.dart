import 'package:flutter/widgets.dart';
import 'package:tab_router/tab_router.dart';

/// {@template app_router}
/// AppRouter widget
/// {@endtemplate}
class AppRouter extends InheritedNotifier<RouterController> with _AppRouterNavigation {
  /// {@macro app_router}
  const AppRouter({
    required RouterController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `AppRouter.maybeOf(context)`
  static AppRouter? maybeOf(BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<AppRouter>()
      : context.getElementForInheritedWidgetOfExactType<AppRouter>()?.widget as AppRouter?;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a AppRouter of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `AppRouter.of(context)`
  static AppRouter of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(AppRouter oldWidget) => !identical(oldWidget.controller, controller);
}

mixin _AppRouterNavigation on InheritedNotifier<RouterController> {
  static Never _notFound() => throw ArgumentError('Not found', 'not_found');

  NavigatorState get navigator => notifier?.navigator ?? _notFound();

  RouterController get controller => notifier ?? _notFound();

  TabRouteState get state => controller.value;

  void nav(TabRouteState Function(TabRouteState state) change) => controller.setState(change(state));

  void navTab(TabRouteState Function(TabRouteState state) change) => throw UnimplementedError();

  void push(String name, {Map<String, String>? arguments}) => throw UnimplementedError();

  void pushTab(String tab, String name, {Map<String, String>? arguments, bool activate = false}) =>
      throw UnimplementedError();

  void activateTab(String tab) => throw UnimplementedError();

  void pop(String tab, String name, {Map<String, String>? arguments}) => throw UnimplementedError();

  void popTab(String tab, String name, {Map<String, String>? arguments, bool activate = false}) =>
      throw UnimplementedError();
}
