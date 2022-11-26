import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'adaptive_page.dart';
import 'inherited_tab_router.dart';
import 'tab.dart';
import 'tab_router_state.dart';
import 'tabs_stack.dart';

class TabRouterDelegate extends RouterDelegate<TabRouterState> with ChangeNotifier, _AppNavigatorMixin {
  TabRouterDelegate();

  @override
  TabRouterState get currentConfiguration {
    final state = _currentConfiguration;
    if (state == null) throw UnsupportedError('Initial configuration not set');
    return state;
  }

  TabRouterState? _currentConfiguration;

  @override
  Future<void> setNewRoutePath(covariant TabRouterState configuration) {
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
  Widget build(BuildContext context) => Navigator(
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
          for (final page in currentConfiguration.pages)
            AdaptivePage(
              name: page.name,
              builder: (context) => InheritedTabRouter.of(context).screenBuilder(context, page.name, page.arguments),
            ),
          AdaptivePage(
            name: 'Tabs',
            builder: (context) => TabsStack(
              builder: (BuildContext context, Tab tab, Map<String, String> argument) => IndexedStack(
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
          ),
        ],
        onPopPage: _onPopPage,
      );

  bool _onPopPage(Route<Object?> route, Object? result) {
    if (!route.didPop(result)) return false;
    final previous = _currentConfiguration?.previous;
    if (previous == null) return false;
    setNewRoutePath(previous);
    return true;
  }
}

mixin _AppNavigatorMixin {
  NavigatorState? get navigator => _modalObserver.navigator;
  final NavigatorObserver _modalObserver = RouteObserver<ModalRoute<Object?>>();
}
