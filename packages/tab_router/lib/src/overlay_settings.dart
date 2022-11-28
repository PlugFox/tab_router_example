import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' show RouteSettings;

abstract class OverlaySettings implements List<RouteSettings> {
  factory OverlaySettings(List<RouteSettings> pages) = _OverlaySettingsView;

  factory OverlaySettings.empty() = _OverlaySettingsView.empty;

  abstract final bool canPop;

  OverlaySettings copyWith({
    List<RouteSettings>? newPages,
  });

  OverlaySettings maybePop();
}

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
}
