import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'inherited_tab_router.dart';
import 'tab_route_state.dart';
import 'utils.dart';

@internal
class TabRouterDelegate extends RouterDelegate<TabRouteState> with ChangeNotifier, _NavigatorMixin, RouterController {
  TabRouterDelegate();

  @override
  TabRouteState get currentConfiguration {
    final state = _currentConfiguration;
    if (state == null) throw UnsupportedError('Initial configuration not set');
    return state;
  }

  TabRouteState? _currentConfiguration;

  @override
  Future<void> setNewRoutePath(covariant TabRouteState configuration) {
    // If unchanged, do nothing
    //if (_currentConfiguration == configuration) return SynchronousFuture<void>(null);
    _currentConfiguration = configuration;
    notifyListeners();

    // Use [SynchronousFuture] so that the initial url is processed
    // synchronously and remove unwanted initial animations on deep-linking
    return SynchronousFuture<void>(null);
  }

  @override
  Future<bool> popRoute() {
    final nav = navigator;
    if (nav == null) return SynchronousFuture<bool>(false);
    return nav.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final inhTabRouter = InheritedTabRouter.of(context, listen: false);
    return Navigator(
      // TODO: key: navigatorKey,
      // TODO: restorationScopeId: restorationScopeId,
      transitionDelegate: const DefaultTransitionDelegate<Object?>(),
      // TODO: onUnknownRoute: _onUnknownRoute,
      reportsRouteUpdateToEngine: true,
      observers: <NavigatorObserver>[
        _modalObserver,
        // TODO: ...observers
      ],
      pages: <Page<void>>[
        for (final route in currentConfiguration.pages)
          inhTabRouter.pageBuilder(
            context,
            RouterUtils.safeRouteName(route.name),
            RouterUtils.safeRouteArguments(route.arguments),
          ),
        /* NoOptPage(
          name: 'Tabs',
          builder: (context) => TabsStack(
            builder: (BuildContext context, String tab, Map<String, String> argument) => IndexedStack(
              index: tab.index,
              children: <Widget>[
                for (final tab in InheritedTabRouter.of(context).tabs)
                  Navigator(
                    pages: currentConfiguration.tabs[tab]!,
                    onPopPage: _onPopPage,
                  ),
              ],
            ),
          ),
        ),*/
      ],
      onPopPage: _onPopPage,
    );
  }

  bool _onPopPage(Route<Object?> route, Object? result) {
    if (!route.didPop(result)) return false;
    final previous = _currentConfiguration?.previous;
    if (previous == null) return false;
    setNewRoutePath(previous);
    return true;
  }
}

mixin _NavigatorMixin {
  NavigatorState? get navigator => _modalObserver.navigator;
  final NavigatorObserver _modalObserver = RouteObserver<ModalRoute<Object?>>();
}

mixin RouterController on RouterDelegate<TabRouteState>, _NavigatorMixin, ChangeNotifier {
  @override
  TabRouteState get currentConfiguration;
}
