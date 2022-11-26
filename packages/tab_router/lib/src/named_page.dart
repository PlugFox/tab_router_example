import 'package:flutter/widgets.dart';

abstract class NamedPage extends Page<void> {
  NamedPage({
    required String name,
    Map<String, String>? arguments,
    super.restorationId,
  }) : super(
          key: ValueKey<int>(Object.hashAll(<Object?>[name, arguments])),
          name: name,
          arguments: arguments,
        );

  @override
  String get name => super.name!;

  @override
  Map<String, String> get arguments => super.arguments as Map<String, String>? ?? <String, String>{};
}
