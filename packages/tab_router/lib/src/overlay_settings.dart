import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' show RouteSettings;
import 'package:meta/meta.dart';

import 'named_route_settings.dart';

abstract class OverlaySettings implements List<NamedRouteSettings> {
  factory OverlaySettings(List<NamedRouteSettings> pages) = _OverlaySettingsView;

  factory OverlaySettings.empty() = _OverlaySettingsView.empty;

  abstract final bool canPop;

  OverlaySettings copyWith({List<RouteSettings>? newPages});

  OverlaySettings maybePop();
}

@immutable
class _OverlaySettingsView extends UnmodifiableListView<NamedRouteSettings> implements OverlaySettings {
  _OverlaySettingsView(List<NamedRouteSettings> source)
      : _source = source,
        super(source);

  _OverlaySettingsView.empty()
      : _source = const <NamedRouteSettings>[],
        super(const <NamedRouteSettings>[]);

  final List<NamedRouteSettings> _source;

  @override
  bool get canPop => isNotEmpty;

  @override
  OverlaySettings copyWith({
    List<RouteSettings>? newPages,
  }) =>
      _OverlaySettingsView(
        newPages?.map<NamedRouteSettings?>(NamedRouteSettings.from).whereType<NamedRouteSettings>().toList() ?? _source,
      );

  @override
  OverlaySettings maybePop() => canPop ? _OverlaySettingsView(_source.sublist(0, _source.length - 1)) : this;

  @override
  int get hashCode => _source.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _OverlaySettingsView && const ListEquality<NamedRouteSettings>().equals(_source, other._source);
}
