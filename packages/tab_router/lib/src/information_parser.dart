import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'tab_route_state.dart';

/// Converts between incoming Strings and a [TabRouteState].
@internal
class TabRouteInformationParser implements RouteInformationParser<TabRouteState> {
  /// Creates a [TabRouteInformationParser].
  TabRouteInformationParser();

  @override
  Future<TabRouteState> parseRouteInformationWithDependencies(
    RouteInformation routeInformation,
    BuildContext context,
  ) =>
      parseRouteInformation(routeInformation);

  @override
  Future<TabRouteState> parseRouteInformation(RouteInformation routeInformation) =>
      SynchronousFuture<TabRouteState>(TabRouteState.fromLocation(routeInformation.location));

  @override
  RouteInformation restoreRouteInformation(TabRouteState configuration) =>
      RouteInformation(location: configuration.location);
}
