import 'package:meta/meta.dart';

@internal
@sealed
abstract class RouterUtils {
  RouterUtils._();

  static const String $unknownRouteName = '_@unknown';
  static const String $currentTabKey = '_@c';
  static const String $tabPrefix = '_@t#';

  static String safeRouteName(String? name) => (name == null || name.isEmpty) ? $unknownRouteName : name;

  static Map<String, String> safeRouteArguments(Object? arguments) {
    if (arguments != null && arguments is Map<String, String>) return arguments;
    return const <String, String>{};
  }

  static Uri? safeLocationToUri(String? location) {
    if (location == null || location.isEmpty || location == '/') return null;
    return Uri.tryParse(location);
  }
}
