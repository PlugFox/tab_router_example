import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../router/routes.dart';

/// {@template error_screen}
/// ErrorScreen widget
/// {@endtemplate}
class ErrorScreen extends StatelessWidget {
  /// {@macro error_screen}
  const ErrorScreen({this.exception, this.tryAgain, super.key});

  final Exception? exception;
  final void Function(BuildContext context)? tryAgain;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    'Something went wrong',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                ..._buildButtons(context),
              ],
            ),
          ),
        ),
      );

  Iterable<Widget> _buildButtons(BuildContext context) sync* {
    void pop(BuildContext context) =>
        Navigator.canPop(context) ? Navigator.pop(context) : GoRouter.of(context).goHome();

    yield const SizedBox(height: 16);
    if (tryAgain != null) {
      yield ElevatedButton.icon(
        label: const Text('Try again'),
        icon: const Icon(Icons.run_circle),
        onPressed: () {
          tryAgain?.call(context);
          HapticFeedback.mediumImpact().ignore();
        },
      );
      yield const SizedBox(height: 16);
      yield OutlinedButton.icon(
        icon: Icon(Icons.adaptive.arrow_back),
        label: const Text('Go back'),
        onPressed: () {
          pop(context);
          HapticFeedback.mediumImpact().ignore();
        },
      );
      return;
    }
    yield ElevatedButton.icon(
      icon: Icon(Icons.adaptive.arrow_back),
      label: const Text('Go back'),
      onPressed: () {
        pop(context);
        HapticFeedback.mediumImpact().ignore();
      },
    );
  }
}
