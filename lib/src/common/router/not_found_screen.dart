import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_router/tab_router.dart';

/// {@template not_found_screen}
/// NotFoundScreen widget
/// {@endtemplate}
class NotFoundScreen extends StatelessWidget {
  /// {@macro not_found_screen}
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Not found'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Not found', style: TextStyle(fontSize: 24)),
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : AppRouter.of(context).reset();
                  HapticFeedback.mediumImpact().ignore();
                },
                child: const Text('Go back'),
              )
            ],
          ),
        ),
      );
}
