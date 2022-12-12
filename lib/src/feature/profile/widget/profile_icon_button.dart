import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_router/tab_router.dart';

/// {@template profile_icon_button}
/// ProfileIconButton widget
/// {@endtemplate}
class ProfileIconButton extends StatelessWidget {
  /// {@macro profile_icon_button}
  const ProfileIconButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          AppRouter.of(context).push('profile');
          HapticFeedback.mediumImpact().ignore();
        },
        icon: const Icon(Icons.person),
      );
}
