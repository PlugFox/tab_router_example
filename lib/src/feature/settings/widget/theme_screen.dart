import 'package:flutter/material.dart';

import '../../../common/widget/common_actions.dart';
import 'theme_scope.dart';

/// {@template theme_screen}
/// ThemeScreen widget
/// {@endtemplate}
class ThemeScreen extends StatelessWidget {
  /// {@macro theme_screen}
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Theme'),
          actions: CommonActions(),
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: const Text('Theme'),
                subtitle: const Text('Change theme to dark or light'),
                onTap: () => ThemeScope.toggle(context),
              ),
            ],
          ),
        ),
      );
}
