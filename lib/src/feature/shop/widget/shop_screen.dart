import 'package:flutter/material.dart';

import '../../../common/widget/common_actions.dart';

/// {@template shop_screen}
/// ShopScreen widget
/// {@endtemplate}
class ShopScreen extends StatelessWidget {
  /// {@macro shop_screen}
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Shop'),
          actions: CommonActions(),
        ),
        body: const SafeArea(
          child: Center(
            child: Text('Shop'),
          ),
        ),
      );
}
