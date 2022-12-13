import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../common/util/storage.dart';

/// {@template theme_scope}
/// ThemeScope widget
/// {@endtemplate}
class ThemeScope extends StatefulWidget {
  /// {@macro theme_scope}
  const ThemeScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  static ThemeMode modeOf(BuildContext context, {bool listen = true}) =>
      _InheritedThemeScope.of(context, listen: listen).isDarkMode ? ThemeMode.dark : ThemeMode.light;

  static ThemeData dataOf(BuildContext context, {bool listen = true}) =>
      _InheritedThemeScope.of(context, listen: listen).isDarkMode ? ThemeData.dark() : ThemeData.light();

  static void toggle(BuildContext context) => _InheritedThemeScope.of(context, listen: false).state.toggle();

  @override
  State<ThemeScope> createState() => _ThemeScopeState();
}

class _ThemeScopeState extends State<ThemeScope> {
  static const String _$key = 'is_dark_mode';
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = $storage.getBool(_$key) ?? ui.window.platformBrightness == Brightness.dark;
  }

  void toggle() => setState(() => $storage.setBool(_$key, isDarkMode = !isDarkMode).ignore());

  @override
  Widget build(BuildContext context) => _InheritedThemeScope(
        isDarkMode: isDarkMode,
        state: this,
        child: widget.child,
      );
}

class _InheritedThemeScope extends InheritedWidget {
  const _InheritedThemeScope({
    required this.isDarkMode,
    required this.state,
    required super.child,
  });

  final bool isDarkMode;
  final _ThemeScopeState state;

  static _InheritedThemeScope? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedThemeScope>()
      : context.getElementForInheritedWidgetOfExactType<_InheritedThemeScope>()?.widget as _InheritedThemeScope?;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a ThemeScope of the exact type',
        'out_of_scope',
      );

  static _InheritedThemeScope of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedThemeScope oldWidget) => !identical(isDarkMode, oldWidget.isDarkMode);
}
