import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../widget/error_screen.dart';
import 'modal_route_analytics_observer.dart';
import 'routes.dart';

abstract class _AppRouterBase {}

class AppRouter = _AppRouterBase with _AppRouterObservers, _AppRouterDelegate, _AppRouterShortcuts, _AppRouterGoRouter;

mixin _AppRouterObservers {
  final RouteObserver<ModalRoute<void>> _routeObserver = RouteObserver<ModalRoute<void>>();
  final NavigatorObserver _analyticsObserver = ModalRouteAnalyticsObserver();
}

mixin _AppRouterDelegate {
  abstract final RouterDelegate<Object> routerDelegate;
  abstract final RouteInformationParser<Object> routeInformationParser;
  abstract final RouteInformationProvider routeInformationProvider;
  abstract final ValueListenable<RouteInformation> routeInformationListenable;
  abstract final RouteInformation routeInformation;
}

mixin _AppRouterShortcuts on _AppRouterObservers, _AppRouterDelegate {
  NavigatorState? get navigator => _routeObserver.navigator;
  bool get isReady => navigator != null;
  String? get location => routeInformation.location;
  Uri get uri => Uri.parse(location ?? '/');
  Map<String, String> get queryParameters => UnmodifiableMapView<String, String>(uri.queryParameters);
}

mixin _AppRouterGoRouter on _AppRouterDelegate, _AppRouterObservers {
  late final GoRouter _router = GoRouter(
    restorationScopeId: 'router',
    routes: $routes,
    //refreshListenable: ,
    //redirect: ,
    //initialLocation: ,
    //navigatorBuilder: ,
    debugLogDiagnostics: kDebugMode,
    observers: <NavigatorObserver>[
      _routeObserver,
      _analyticsObserver,
    ],
    errorBuilder: (context, state) => ErrorScreen(exception: state.error),
  );

  @override
  RouterDelegate<Object> get routerDelegate => _router.routerDelegate;

  @override
  RouteInformationParser<Object> get routeInformationParser => _router.routeInformationParser;

  @override
  RouteInformationProvider get routeInformationProvider => _router.routeInformationProvider;

  @override
  ValueListenable<RouteInformation> get routeInformationListenable => _router.routeInformationProvider;

  @override
  RouteInformation get routeInformation => routeInformationListenable.value;
}
