import 'package:flutter/material.dart';

/// {@template error_screen}
/// ErrorScreen widget
/// {@endtemplate}
class ErrorScreen extends StatelessWidget {
  /// {@macro error_screen}
  const ErrorScreen({this.exception, super.key});

  final Exception? exception;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const SafeArea(
          child: Placeholder(),
        ),
      );
}
