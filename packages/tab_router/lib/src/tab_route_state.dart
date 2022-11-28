import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import 'overlay_settings.dart';
import 'tabs_pages.dart';
import 'utils.dart';

export 'overlay_settings.dart';
export 'tabs_pages.dart';

@immutable
abstract class TabRouteState {
  factory TabRouteState({
    required OverlaySettings pages,
    required TabsSettings tabs,
  }) = _TabRouterState;

  factory TabRouteState.fromLocation(String? location) => _$fromLocation(location);

  /// Previus configuration
  abstract final TabRouteState? previous;

  /// Represents the current routing state of the application as a string.
  abstract final String location;

  /// Overlay pages above the tabs.
  abstract final OverlaySettings pages;

  /// Tabs settings.
  abstract final TabsSettings tabs;

  TabRouteState copyWith({
    OverlaySettings? newPages,
    TabsSettings? newTabs,
  });
}

class _TabRouterState implements TabRouteState {
  _TabRouterState({
    required this.pages,
    required this.tabs,
  });

  @override
  final OverlaySettings pages;

  @override
  final TabsSettings tabs;

  @override
  late final String location = _$toLocation(this);

  @override
  late final TabRouteState? previous = () {
    if (pages.isNotEmpty) return copyWith(newPages: pages.maybePop());
    if (tabs.canPop) return copyWith(newTabs: tabs.maybePop());
    return null;
  }();

  @override
  TabRouteState copyWith({
    OverlaySettings? newPages,
    TabsSettings? newTabs,
  }) =>
      _TabRouterState(
        pages: newPages ?? pages,
        tabs: newTabs ?? tabs,
      );

  @override
  String toString() => location;
}

TabRouteState _$fromLocation(String? location) {
  if (location == null) return _TabRouterState(pages: OverlaySettings.empty(), tabs: TabsSettings.empty());
  final uri = Uri.tryParse(location);
  if (uri == null) return _$fromLocation(null);
  final pathSegments = uri.pathSegments;
  final queryParameters = uri.queryParameters;

  RouteSettings decodeRoute(String page) {
    final delimiter = page.indexOf('-');
    final name = delimiter == -1 ? page : page.substring(0, delimiter).trim();
    final arguments = delimiter == -1
        ? <MapEntry<String, String>>[]
        : page
            .substring(delimiter + 1)
            .trim()
            .split('&')
            .map<MapEntry<String, String>?>((e) {
              final delimiter = e.indexOf('=');
              if (delimiter == -1) return null;
              return MapEntry(e.substring(0, delimiter).trim(), e.substring(delimiter + 1).trim());
            })
            .whereType<MapEntry<String, String>>()
            .toList(growable: false);

    return RouteSettings(
      name: RouterUtils.safeRouteName(name),
      arguments: Map<String, String>.fromEntries(arguments),
    );
  }

  List<RouteSettings> decodeRoutes(Iterable<String> pages) =>
      pages.map<RouteSettings>(decodeRoute).toList(growable: false);

  String? decodeTab(String tab) {
    if (!tab.startsWith(RouterUtils.$tabPrefix)) return null;
    return tab.substring(RouterUtils.$tabPrefix.length);
  }

  final tabs = Map<String, List<RouteSettings>>.fromEntries(
    queryParameters.entries
        .where((e) => e.key.startsWith(RouterUtils.$tabPrefix))
        .map<MapEntry<String, List<RouteSettings>>?>((e) {
      final tab = decodeTab(e.key);
      if (tab == null) return null;
      final routes = decodeRoutes(Uri.tryParse(e.value)?.pathSegments ?? const <String>[]);
      return MapEntry<String, List<RouteSettings>>(tab, routes);
    }).whereType<MapEntry<String, List<RouteSettings>>>(),
  );

  final currentTab = queryParameters[RouterUtils.$currentTabKey]?.substring(3);
  return TabRouteState(
    pages: OverlaySettings(decodeRoutes(pathSegments)),
    tabs: TabsSettings(
      tabs.keys.firstWhereOrNull((e) => e == currentTab),
      tabs,
    ),
  );
}

String _$toLocation(TabRouteState routeState) {
  String encodeRoute(RouteSettings page) {
    final name = RouterUtils.safeRouteName(page.name);
    final arguments = RouterUtils.safeRouteArguments(page.arguments);
    final buffer = StringBuffer(name);
    if (arguments.isNotEmpty) {
      buffer
        ..write('-')
        ..write(arguments.entries.map((e) => '${e.key}=${e.value}').join('&'));
    }
    return buffer.toString();
  }

  List<String> encodeRoutes(Iterable<RouteSettings> pages) => pages.map<String>(encodeRoute).toList(growable: false);

  String encodeTab(String tab) => '${RouterUtils.$tabPrefix}$tab';

  final currentTab = routeState.tabs.current;
  final tabs = routeState.tabs.entries;
  final uri = Uri(
    pathSegments: encodeRoutes(routeState.pages),
    queryParameters: <String, String>{
      for (final e in tabs) encodeTab(e.key): Uri(pathSegments: encodeRoutes(e.value)).toString(),
      if (currentTab != null) RouterUtils.$currentTabKey: currentTab,
    },
  );

  String makeAbsolute(String path) => path.startsWith('/') ? path : '/$path';
  return makeAbsolute(uri.toString());
}
