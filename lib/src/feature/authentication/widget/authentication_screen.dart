import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authentication_scope.dart';

/// {@template authentication_screen}
/// AuthenticationScreen widget
/// {@endtemplate}
class AuthenticationScreen extends StatelessWidget {
  /// {@macro authentication_screen}
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
        ),
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                AuthenticationScope.signIn(context);
                HapticFeedback.mediumImpact().ignore();
              },
              child: const Text('Sign in'),
            ),
          ),
        ),
      );
}
