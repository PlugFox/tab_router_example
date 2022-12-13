import 'package:flutter/material.dart';

/// {@template breadcrumbs}
/// Breadcrumbs widget
/// {@endtemplate}
class Breadcrumbs extends StatelessWidget {
  /// {@macro breadcrumbs}
  const Breadcrumbs({required this.breadcrumbs, super.key});

  final Map<Widget, VoidCallback?> breadcrumbs;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _buildRow(context, breadcrumbs),
          ),
        ),
      );

  static List<Widget> _buildRow(BuildContext context, Map<Widget, VoidCallback?> breadcrumbs) {
    final list = <Widget>[];
    for (var i = 0; i < breadcrumbs.length; i++) {
      final entry = breadcrumbs.entries.elementAt(i);
      list.add(
        TextButton(
          onPressed: entry.value,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: entry.key,
        ),
      );
      if (i < breadcrumbs.length - 1) list.add(const Icon(Icons.chevron_right));
    }
    return list;
  }
}
