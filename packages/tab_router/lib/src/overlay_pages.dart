import 'package:collection/collection.dart';

import 'named_page.dart';

abstract class OverlayPages implements List<NamedPage> {
  factory OverlayPages(List<NamedPage> pages) = _OverlayPagesView;

  abstract final bool canPop;

  OverlayPages copyWith({
    List<NamedPage>? newPages,
  });

  OverlayPages maybePop();
}

class _OverlayPagesView extends UnmodifiableListView<NamedPage> implements OverlayPages {
  _OverlayPagesView(List<NamedPage> source)
      : _source = source,
        super(source);

  final List<NamedPage> _source;

  @override
  bool get canPop => isNotEmpty;

  @override
  OverlayPages copyWith({
    List<NamedPage>? newPages,
  }) =>
      _OverlayPagesView(newPages ?? _source);

  @override
  OverlayPages maybePop() => canPop ? _OverlayPagesView(_source.sublist(0, _source.length - 1)) : this;
}
