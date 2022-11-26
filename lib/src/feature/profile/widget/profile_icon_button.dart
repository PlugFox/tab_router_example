import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/router/routes.dart';

/// {@template profile_icon_button}
/// ProfileIconButton widget
/// {@endtemplate}
class ProfileIconButton extends StatelessWidget {
  /// {@macro profile_icon_button}
  const ProfileIconButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => GoRouter.of(context).goProfile(),
        icon: const Icon(Icons.person),
      );
}
