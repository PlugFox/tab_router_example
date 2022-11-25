import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/router/routes.dart';

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
            onPressed: () => GoRouter.of(context).goHome(),
          ),
          title: const Text('Profile'),
        ),
        body: const SafeArea(
          child: Center(
            child: Text('Profile'),
          ),
        ),
      );
}
