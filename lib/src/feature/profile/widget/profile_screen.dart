import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template profile_screen}
/// ProfileScreen widget
/// {@endtemplate}
class ProfileScreen extends StatelessWidget {
  /// {@macro profile_screen}
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.adaptive.arrow_back),
            onPressed: () {
              Navigator.maybePop(context);
              HapticFeedback.mediumImpact().ignore();
            },
          ),
          title: const Text('Profile'),
        ),
        body: const SafeArea(
          child: Center(
            child: Text('Full screen profile screen'),
          ),
        ),
      );
}
