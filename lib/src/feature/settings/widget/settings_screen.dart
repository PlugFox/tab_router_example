import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/constants/pubspec.yaml.g.dart' as pubspec;
import '../../../common/widget/common_actions.dart';

/// {@template settings_screen}
/// SettingsScreen widget
/// {@endtemplate}
class SettingsScreen extends StatefulWidget {
  /// {@macro settings_screen}
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void dispose() {
    // TODO: we should dispose pages on hot reload
    // Matiunin Mikhail <plugfox@gmail.com>, 08 December 2022
    print('TODO');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: CommonActions(),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Version'),
                      subtitle: const Text('Show modal alert dialog with version'),
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text('Version'),
                            content: Text(pubspec.version),
                          ),
                        );
                        HapticFeedback.selectionClick().ignore();
                      },
                    ),
                    ListTile(
                      title: const Text('Show License Page'),
                      subtitle: const Text('Show modal screen with license'),
                      onTap: () {
                        showLicensePage(context: context);
                        HapticFeedback.mediumImpact().ignore();
                      },
                    ),
                    ListTile(
                      title: const Text('Bottom Sheet'),
                      subtitle: const Text('Show bottom sheet'),
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          useRootNavigator: true,
                          builder: (context) => BottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            constraints: const BoxConstraints(
                              minHeight: 128,
                            ),
                            onClosing: () {},
                            enableDrag: false,
                            builder: (context) => const Center(child: Text('Hello there')),
                          ),
                        );
                        HapticFeedback.mediumImpact().ignore();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                height: 16,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    pubspec.version,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
