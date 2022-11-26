import 'package:flutter/material.dart' hide Tab;

import 'tab.dart';

/// {@template tabs_stack}
/// TabsStack widget
/// {@endtemplate}
class TabsStack extends StatelessWidget {
  /// {@macro tabs_stack}
  const TabsStack({required this.builder, super.key});

  final Widget Function(BuildContext context, Tab tab, Map<String, String> arguments) builder;

  @override
  Widget build(BuildContext context) => const Placeholder();
}
