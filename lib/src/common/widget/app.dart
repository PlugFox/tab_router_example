import 'package:flutter/material.dart';
import 'package:tab_router/tab_router.dart';

import '../../feature/product/widget/product_scope.dart';
import 'material_scope.dart';

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => ProductScope(
        child: TabRouterBuilder(
          builder: (context, delegate) => const MaterialScope(),
          routes: const <String, Widget Function(BuildContext, String, Map<String, String>)>{},
          tabs: const <String>[],
        ),
      );
}
