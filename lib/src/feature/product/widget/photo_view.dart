import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

/// {@template photo_view_screen}
/// PhotoViewScreen widget
/// {@endtemplate}
class PhotoViewScreen extends StatelessWidget {
  /// {@macro photo_view_screen}
  const PhotoViewScreen({required this.child, super.key});

  static Future<void> show(BuildContext context, Widget child) => Navigator.of(context, rootNavigator: true).push<void>(
        PageRouteBuilder<void>(
          pageBuilder: (context, _, __) => PhotoViewScreen(child: child),
          transitionsBuilder: (context, animation, secondayAnimation, child) => ScaleTransition(
            scale: Tween<double>(begin: 1.25, end: 1).animate(animation),
            child: FadeTransition(
              opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
              child: child,
            ),
          ),
          settings: const RouteSettings(name: 'photo_view'),
        ),
      );

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: PhotoView.customChild(
                  basePosition: Alignment.center,
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: 3.0,
                  enableRotation: false,
                  backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                  child: SafeArea(
                    child: Center(
                      child: child,
                    ),
                  ),
                ),
              ),
              if (Navigator.canPop(context)) const PhotoViewBackButton(),
            ],
          ),
        ),
      );
}

/// {@template photo_view_screen}
/// PhotoViewBackButton widget
/// {@endtemplate}
class PhotoViewBackButton extends StatelessWidget {
  /// {@macro photo_view_screen}
  const PhotoViewBackButton({super.key}) : _isLarge = false;

  /// {@macro photo_view_screen}
  const PhotoViewBackButton.large({super.key}) : _isLarge = true;

  final bool _isLarge;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox.square(
              dimension: _isLarge ? 82 : 48,
              child: Material(
                color: Theme.of(context).colorScheme.secondary,
                shape: const CircleBorder(),
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.maybePop(context);
                    HapticFeedback.mediumImpact().ignore();
                  },
                  customBorder: const CircleBorder(),
                  child: Icon(
                    Icons.fullscreen_exit,
                    size: _isLarge ? 48 : 32,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
