import 'dart:async';

//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

import 'error_util/error_util_platform.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'error_util/error_util_browser.dart';

@sealed
abstract class ErrorUtil {
  ErrorUtil._();

  static Future<void> logError(
    Object exception,
    StackTrace stackTrace, {
    String? hint,
    bool fatal = false,
  }) async {
    try {
      if (exception is String) {
        return await logMessage(
          exception,
          stackTrace: stackTrace,
          hint: hint,
          warning: true,
        );
      }
      $captureException(exception, stackTrace, hint, fatal).ignore();
      l.e(exception, stackTrace);
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging error "$error" inside ErrorUtil.logError',
        stackTrace,
      );
    }
  }

  static Future<void> logMessage(
    String message, {
    StackTrace? stackTrace,
    String? hint,
    bool warning = false,
  }) async {
    try {
      l.w(message, stackTrace);
      $captureMessage(message, stackTrace, hint, warning).ignore();
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging error "$error" inside ErrorUtil.logMessage',
        stackTrace,
      );
    }
  }

  @alwaysThrows
  static Never throwWithStackTrace(Object error, StackTrace stackTrace) =>
      Error.throwWithStackTrace(error, stackTrace);

  static String formatMessage(
    Object error, [
    String fallback = 'An error has occurred',
  ]) {
    if (error is String) {
      return error;
    } else if (error is FormatException) {
      return 'Invalid data format';
    } else if (error is TimeoutException) {
      return 'Timeout exceeded';
    } else if (error is UnimplementedError) {
      return 'Not implemented yet';
    } else if (error is UnsupportedError) {
      return 'Unsupported operation';
      /*
    } else if (error is FirebaseAuthException) {
      if (error.code.contains('popup-closed-by-user')) {
        return 'The user closed the authentication window';
      } else if (error.code.contains('account-exists-with-different-credential')) {
        return 'An account already exists with the same email address.\n'
            'Try signing in with another social provider instead.';
      }
      return 'Firebase authentication exception occurred';
    } else if (error is FirebaseException) {
      return 'Firebase exception occurred';
    */
    } else if (error is AssertionError) {
      return 'Assertion error';
    } else if (error is Error) {
      return 'An error has occurred';
    } else if (error is Exception) {
      return 'An exception has occurred';
    } else {
      return fallback;
    }
  }

  static void showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
}
