import 'package:flutter/material.dart';

import '../../../common/router/app_router.dart';
import '../../../common/widget/common_actions.dart';
import '../model/category.dart';
import 'product_scope.dart';

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
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final categories = ProductScope.getCategories(context).where((e) => e.isRoot).toList(growable: false);
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemExtent: 60,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    key: ValueKey<CategoryID>(category.id),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: OutlinedButton(
                      child: Text(category.title),
                      onPressed: () => AppRouter.maybeOf(context)?.pushTab(
                        'category',
                        arguments: <String, String>{'id': category.id},
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
}
