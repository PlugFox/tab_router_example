import 'package:meta/meta.dart';

@sealed
abstract class Analytics {
  Analytics._();

  static void logScreen({required String screenClass, required String screenName}) => Future<void>.value().ignore();

  static void logScreenPage(String screenName) => logScreen(screenClass: 'Page', screenName: screenName);

  static void logScreenScope(String screenName) => logScreen(screenClass: 'Scope', screenName: screenName);
}
