import 'package:flutter/material.dart';

import '../../../common/widget/common_actions.dart';

/// {@template settings_screen}
/// SettingsScreen widget
/// {@endtemplate}
class SettingsScreen extends StatelessWidget {
  /// {@macro settings_screen}
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: CommonActions(),
        ),
        body: const SafeArea(
          child: Center(
            child: Text('Settings'),
          ),
        ),
      );
}
