import 'package:flutter/material.dart' hide Tab;
import 'package:meta/meta.dart';

/// {@template tabs_stack}
/// TabsStack widget
/// {@endtemplate}
@internal
class TabsStack extends StatelessWidget {
  /// {@macro tabs_stack}
  const TabsStack({required this.builder, super.key});

  final Widget Function(BuildContext context, String tab, Map<String, String> arguments) builder;

  @override
  Widget build(BuildContext context) => const Placeholder();
}
