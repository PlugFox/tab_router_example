import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/analytics.dart';

class ModalRouteAnalyticsObserver extends RouteObserver<ModalRoute<Object?>> {
  ModalRouteAnalyticsObserver();

  static const String _kUnknownScreen = 'screen';
  static const String _kUnknownModal = 'modal';

  static void logRoute({required String screenName, String className = 'Page'}) {
    //l.v6('Current route: $screenName');
    Analytics.logScreen(screenName: screenName, screenClass: className);
  }

  PageRoute? _lastPageRoute;

  void _onModalRoute(ModalRoute<Object?> route) {
    final String screenName;
    final String className;
    if (route is PageRoute) {
      _lastPageRoute = route;
      final settings = route.settings;
      screenName = settings.name ?? _kUnknownScreen;
      className = 'Page';
    } else {
      final currentPageName = _lastPageRoute?.settings.name ?? _kUnknownScreen;
      screenName = '$currentPageName:${route.settings.name ?? _kUnknownModal}';
      if (route is RawDialogRoute) {
        className = 'Dialog';
      } else if (route is PopupRoute) {
        className = 'PopupRoute';
      } else {
        className = 'Modal';
      }
    }
    logRoute(screenName: screenName, className: className);
  }

  @override
  void didPush(Route<Object?> route, Route<Object?>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is ModalRoute) _onModalRoute(route);
  }

  @override
  void didReplace({Route<Object?>? newRoute, Route<Object?>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is ModalRoute) _onModalRoute(newRoute);
  }

  @override
  void didPop(Route<Object?> route, Route<Object?>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is ModalRoute && route is ModalRoute) _onModalRoute(previousRoute);
  }
}
