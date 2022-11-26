import 'package:flutter/material.dart';

import '../../feature/product/widget/product_scope.dart';
import 'material_scope.dart';

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => const ProductScope(
        child: MaterialScope(),
      );
}
