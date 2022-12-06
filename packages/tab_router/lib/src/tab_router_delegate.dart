import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'inherited_tab_router.dart';
import 'listenable_selector.dart';
import 'root_page.dart';
import 'tab_route_state.dart';
import 'tabs_stack.dart';
import 'utils.dart';

@internal
class TabRouterDelegate extends RouterDelegate<TabRouteState> with ChangeNotifier implements RouterController {
  TabRouterDelegate();

  @override
  TabRouteState get value => currentConfiguration;

  @override
  NavigatorState? get navigator => _modalObserver.navigator;
  final NavigatorObserver _modalObserver = RouteObserver<ModalRoute<Object?>>();

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

    // TODO: check if the new configuration is valid
    // exclude duplicates
    // Matiunin Mikhail <plugfox@gmail.com>, 06 December 2022
    _currentConfiguration = configuration;
    notifyListeners();

    // Use [SynchronousFuture] so that the initial url is processed
    // synchronously and remove unwanted initial animations on deep-linking
    return SynchronousFuture<void>(null);
  }

  @override
  Future<void> setState(TabRouteState configuration) => setNewRoutePath(configuration);

  @override
  Future<bool> popRoute() {
    final nav = navigator;
    if (nav == null) return SynchronousFuture<bool>(false);
    return nav.maybePop();
  }

  @override
  Future<bool> pop() => popRoute();

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
        RootPage(
          //key: ValueKey<String>(currentConfiguration.tabs.current ?? ''),
          name: 'Tabs',
          restorationId: 'Tabs',
          child: ValueListenableBuilder<TabRouteState>(
            valueListenable: select(
              (controller) => controller.value,
              (prev, next) => prev.tabs != next.tabs,
            ),
            builder: (context, state, _) => inhTabRouter.tabsBuilder(
              context,
              inhTabRouter.tabs,
              state.tabs.current,
              TabsStack(tabsState: state.tabs),
            ),
          ),
        ),
        for (final route in currentConfiguration.pages)
          inhTabRouter.pageBuilder(
            context,
            RouterUtils.safeRouteName(route.name),
            RouterUtils.safeRouteArguments(route.arguments),
          ),
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

abstract class RouterController implements ValueListenable<TabRouteState> {
  abstract final NavigatorState? navigator;

  Future<void> setState(TabRouteState configuration);

  Future<bool> pop();
}
