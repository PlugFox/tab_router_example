import 'package:flutter/material.dart';

import 'authentication_screen.dart';

/// {@template authentication_scope}
/// AuthenticationScope widget
/// {@endtemplate}
class AuthenticationScope extends StatefulWidget {
  /// {@macro authentication_scope}
  const AuthenticationScope({required this.child, super.key});

  final Widget child;

  static void signIn(BuildContext context) => context.findAncestorStateOfType<_AuthenticationScopeState>()!.signIn();

  static void logOut(BuildContext context) => context.findAncestorStateOfType<_AuthenticationScopeState>()!.logOut();

  @override
  State<AuthenticationScope> createState() => _AuthenticationScopeState();
}

class _AuthenticationScopeState extends State<AuthenticationScope> with _AuthenticationScopeStateMixin {
  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        child: _isAuthenticated ? widget.child : const AuthenticationScreen(),
      );
}

mixin _AuthenticationScopeStateMixin on State<AuthenticationScope> {
  bool _isAuthenticated = false;

  @protected
  void signIn() => setState(() => _isAuthenticated = true);

  @protected
  void logOut() => setState(() => _isAuthenticated = false);
}
