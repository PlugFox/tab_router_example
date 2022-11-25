import 'package:flutter/material.dart';

import 'authentication_scope.dart';

/// {@template log_out_button}
/// LogOutButton widget
/// {@endtemplate}
class LogOutButton extends StatelessWidget {
  /// {@macro log_out_button}
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.logout),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () => AuthenticationScope.logOut(context),
      );
}
