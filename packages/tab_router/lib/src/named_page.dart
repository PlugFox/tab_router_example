import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

abstract class NamedPage implements Page<void> {
  NamedPage({
    required this.name,
    Map<String, String> arguments = const <String, String>{},
    LocalKey? key,
  })  : arguments = SplayTreeMap<String, String>.of(arguments, (a, b) => a.compareTo(b)),
        key = key ??
            ValueKey<int>(
              Uri(
                path: name,
                queryParameters: SplayTreeMap<String, String>.of(arguments, (a, b) => a.compareTo(b)),
              ).hashCode,
            );

  @override
  final String name;

  @override
  final Map<String, String> arguments;

  late final Uri location = Uri(path: name, queryParameters: arguments);

  @override
  bool canUpdate(Page<dynamic> other) => other is NamedPage && other.key == key;

  @factory
  @override
  Route<void> createRoute(BuildContext context);

  @override
  final LocalKey key;

  @override
  String? get restorationId => location.toString();

  @override
  int get hashCode => location.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamedPage &&
          name == other.name &&
          const MapEquality<String, String>().equals(arguments, other.arguments);

  @override
  String toString() => location.toString();
}
