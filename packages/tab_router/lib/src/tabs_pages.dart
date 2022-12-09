import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' show RouteSettings;
import 'package:meta/meta.dart';

import 'named_route_settings.dart';

typedef TabName = String;

@internal
abstract class TabsSettings implements Map<TabName, List<NamedRouteSettings>> {
  factory TabsSettings(TabName? current, Map<TabName, List<NamedRouteSettings>> pages) = _TabsSettingsView;
  factory TabsSettings.empty() = _TabsSettingsView.empty;

  abstract final TabName? current;

  abstract final bool canPop;

  TabsSettings copyWith({
    TabName? newCurrent,
    Map<TabName, List<RouteSettings>>? newPages,
  });

  TabsSettings maybePop();
}

@immutable
class _TabsSettingsView extends UnmodifiableMapBase<TabName, List<NamedRouteSettings>> implements TabsSettings {
  _TabsSettingsView(TabName? current, this._pages)
      : current = _evalCurrentTab(current, _pages.keys.toList(growable: false));
  _TabsSettingsView.empty()
      : current = null,
        _pages = const <TabName, List<NamedRouteSettings>>{};

  static TabName? _evalCurrentTab(TabName? current, List<TabName> tabs) {
    //assert(current == null || tabs.contains(current), 'Current tab must be in pages');
    TabName? firsOrNull() => tabs.isNotEmpty ? tabs.first : null;
    return current ?? firsOrNull();
  }

  @override
  final TabName? current;

  @override
  bool get canPop => current != null && (_pages[current]?.isNotEmpty ?? false);

  final Map<TabName, List<NamedRouteSettings>> _pages;

  @override
  Iterable<TabName> get keys => _pages.keys;

  @override
  List<NamedRouteSettings>? operator [](Object? key) => _pages[key];

  @override
  TabsSettings copyWith({
    TabName? newCurrent,
    Map<TabName, List<RouteSettings>>? newPages,
  }) =>
      _TabsSettingsView(
        newCurrent ?? current,
        <TabName, List<NamedRouteSettings>>{
          ..._pages,
          if (newPages != null)
            ...newPages.map<TabName, List<NamedRouteSettings>>(
              (key, value) => MapEntry(
                key,
                value.map<NamedRouteSettings?>(NamedRouteSettings.from).whereType<NamedRouteSettings>().toList(),
              ),
            ),
        },
      );

  @override
  TabsSettings maybePop() => canPop
      ? copyWith(
          newPages: <TabName, List<NamedRouteSettings>>{
            ..._pages,
            current!: _pages[current]!.sublist(0, _pages[current]!.length - 1),
          },
        )
      : this;

  @override
  int get hashCode => Object.hashAll(<Object?>[current, _pages]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TabsSettingsView &&
          current == other.current &&
          const DeepCollectionEquality().equals(_pages, other._pages);
}
