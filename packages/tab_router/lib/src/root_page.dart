import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Root page with no transition functionality.
@internal
class RootPage extends Page<void> {
  /// Constructor for a root page with no transition functionality.
  const RootPage({
    required this.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  });

  final Widget child;

  @override
  Route<void> createRoute(BuildContext context) => PageRouteBuilder<void>(
        settings: this,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) => child,
      );
}
