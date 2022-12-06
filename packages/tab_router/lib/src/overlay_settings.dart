import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' show RouteSettings;
import 'package:meta/meta.dart';

abstract class OverlaySettings implements List<RouteSettings> {
  factory OverlaySettings(List<RouteSettings> pages) = _OverlaySettingsView;

  factory OverlaySettings.empty() = _OverlaySettingsView.empty;

  abstract final bool canPop;

  OverlaySettings copyWith({
    List<RouteSettings>? newPages,
  });

  OverlaySettings maybePop();
}

@immutable
class _OverlaySettingsView extends UnmodifiableListView<RouteSettings> implements OverlaySettings {
  _OverlaySettingsView(List<RouteSettings> source)
      : _source = source,
        super(source);

  _OverlaySettingsView.empty()
      : _source = const <RouteSettings>[],
        super(const <RouteSettings>[]);

  final List<RouteSettings> _source;

  @override
  bool get canPop => isNotEmpty;

  @override
  OverlaySettings copyWith({
    List<RouteSettings>? newPages,
  }) =>
      _OverlaySettingsView(newPages ?? _source);

  @override
  OverlaySettings maybePop() => canPop ? _OverlaySettingsView(_source.sublist(0, _source.length - 1)) : this;

  @override
  int get hashCode => _source.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _OverlaySettingsView && const ListEquality<RouteSettings>().equals(_source, other._source);
}
