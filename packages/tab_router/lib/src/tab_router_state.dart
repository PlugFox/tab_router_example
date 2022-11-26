import 'overlay_pages.dart';
import 'tabs_pages.dart';

abstract class TabRouterState {
  factory TabRouterState({
    required OverlayPages pages,
    required TabsPages tabs,
  }) = _TabRouterState;

  abstract final TabRouterState? previous;

  abstract final OverlayPages pages;

  abstract final TabsPages tabs;

  TabRouterState copyWith({
    OverlayPages? newPages,
    TabsPages? newTabs,
  });
}

class _TabRouterState implements TabRouterState {
  _TabRouterState({
    required this.pages,
    required this.tabs,
  });

  @override
  final OverlayPages pages;

  @override
  final TabsPages tabs;

  @override
  TabRouterState? get previous {
    if (pages.isNotEmpty) return copyWith(newPages: pages.maybePop());
    if (tabs.canPop) return copyWith(newTabs: tabs.maybePop());
    return null;
  }

  @override
  TabRouterState copyWith({
    OverlayPages? newPages,
    TabsPages? newTabs,
  }) =>
      _TabRouterState(
        pages: newPages ?? pages,
        tabs: newTabs ?? tabs,
      );
}
