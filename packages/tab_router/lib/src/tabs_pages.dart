import 'dart:collection';

import 'package:flutter/widgets.dart' show RouteSettings;
import 'package:meta/meta.dart';

typedef TabName = String;

@internal
abstract class TabsSettings implements Map<TabName, List<RouteSettings>> {
  factory TabsSettings(TabName? current, Map<TabName, List<RouteSettings>> pages) = _TabsSettingsView;
  factory TabsSettings.empty() = _TabsSettingsView.empty;

  abstract final TabName? current;

  abstract final bool canPop;

  TabsSettings copyWith({
    TabName? newCurrent,
    Map<TabName, List<RouteSettings>>? newPages,
  });

  TabsSettings maybePop();
}

class _TabsSettingsView extends UnmodifiableMapBase<TabName, List<RouteSettings>> implements TabsSettings {
  _TabsSettingsView(TabName? current, this._pages)
      : current = _evalCurrentTab(current, _pages.keys.toList(growable: false));
  _TabsSettingsView.empty()
      : current = null,
        _pages = const <TabName, List<RouteSettings>>{};

  static TabName? _evalCurrentTab(TabName? current, List<TabName> tabs) {
    assert(current == null || tabs.contains(current), 'Current tab must be in pages');
    TabName? firsOrNull() => tabs.isNotEmpty ? tabs.first : null;
    if (current == null) return firsOrNull();
    if (tabs.contains(current)) return current;
    return firsOrNull();
  }

  @override
  final TabName? current;

  @override
  bool get canPop => current != null && _pages[current]!.length > 1;

  final Map<TabName, List<RouteSettings>> _pages;

  @override
  Iterable<TabName> get keys => _pages.keys;

  @override
  List<RouteSettings>? operator [](Object? key) => _pages[key];

  @override
  TabsSettings copyWith({
    TabName? newCurrent,
    Map<TabName, List<RouteSettings>>? newPages,
  }) =>
      _TabsSettingsView(
        newCurrent ?? current,
        <TabName, List<RouteSettings>>{
          ..._pages,
          if (newPages != null) ...newPages,
        },
      );

  @override
  TabsSettings maybePop() => canPop
      ? copyWith(
          newPages: <TabName, List<RouteSettings>>{
            ..._pages,
            current!: _pages[current]!.sublist(0, _pages[current]!.length - 1),
          },
        )
      : this;
}
