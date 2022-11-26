import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'tab.dart';

/// {@template inherited_tab_router}
/// InheritedTabRouter widget
/// {@endtemplate}
class InheritedTabRouter extends InheritedWidget {
  /// {@macro inherited_tab_router}
  const InheritedTabRouter({
    required super.child,
    required this.screenBuilder,
    required this.tabs,
    super.key,
  });

  final Widget Function(BuildContext context, String name, Map<String, String> arguments) screenBuilder;
  final List<Tab> tabs;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `InheritedTabRouter.maybeOf(context)`
  static InheritedTabRouter? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<InheritedTabRouter>();
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<InheritedTabRouter>()?.widget;
      return inhW is InheritedTabRouter ? inhW : null;
    }
  }

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a InheritedTabRouter of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `InheritedTabRouter.of(context)`
  static InheritedTabRouter of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant InheritedTabRouter oldWidget) => !listEquals<Tab>(tabs, oldWidget.tabs);
}
