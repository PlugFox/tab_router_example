import 'dart:collection';

import 'named_page.dart';
import 'tab.dart';

abstract class TabsPages implements Map<Tab, List<NamedPage>> {
  factory TabsPages(Tab current, Map<Tab, List<NamedPage>> pages) = _TabsPagesView;

  abstract final Tab current;

  abstract final bool canPop;

  TabsPages copyWith({
    Tab? newCurrent,
    Map<Tab, List<NamedPage>>? newPages,
  });

  TabsPages maybePop();
}

class _TabsPagesView extends UnmodifiableMapBase<Tab, List<NamedPage>> implements TabsPages {
  _TabsPagesView(this.current, this._pages);

  @override
  final Tab current;

  @override
  bool get canPop => _pages[current]!.length > 1;

  final Map<Tab, List<NamedPage>> _pages;

  @override
  Iterable<Tab> get keys => _pages.keys;

  @override
  List<NamedPage>? operator [](Object? key) => _pages[key];

  @override
  TabsPages copyWith({
    Tab? newCurrent,
    Map<Tab, List<NamedPage>>? newPages,
  }) =>
      _TabsPagesView(
        newCurrent ?? current,
        {
          ..._pages,
          if (newPages != null) ...newPages,
        },
      );

  @override
  TabsPages maybePop() => canPop
      ? copyWith(
          newPages: <Tab, List<NamedPage>>{
            ..._pages,
            current: _pages[current]!.sublist(0, _pages[current]!.length - 1),
          },
        )
      : this;
}
