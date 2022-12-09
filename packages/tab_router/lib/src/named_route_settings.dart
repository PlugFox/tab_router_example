import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' show RouteSettings;
import 'package:meta/meta.dart';

@immutable
class NamedRouteSettings implements RouteSettings {
  NamedRouteSettings({
    required this.name,
    required Map<String, String> arguments,
  }) : arguments = arguments is SplayTreeMap<String, String>
            ? arguments
            : SplayTreeMap<String, String>.of(arguments, (a, b) => a.compareTo(b));

  static NamedRouteSettings? from(RouteSettings? settings) {
    if (settings == null) return null;
    if (settings is NamedRouteSettings) return settings;
    final name = settings.name;
    final arguments = settings.arguments;
    if (name == null || arguments is! Map?) return null;
    return NamedRouteSettings(
      name: name,
      arguments: SplayTreeMap<String, String>.of(
        <String, String>{
          if (arguments != null)
            for (final entry in arguments.entries) entry.key.toString(): entry.value.toString(),
        },
        (a, b) => a.compareTo(b),
      ),
    );
  }

  @override
  final String name;

  @override
  final Map<String, String> arguments;

  late final Uri location = Uri(path: name, queryParameters: arguments);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamedRouteSettings &&
          name == other.name &&
          const MapEquality<String, String>().equals(arguments, other.arguments);

  @override
  int get hashCode => location.hashCode;

  @override
  String toString() => location.toString();
}
