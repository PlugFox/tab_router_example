import 'package:flutter/material.dart';

import '../../../common/widget/common_actions.dart';
import '../model/category.dart';
import 'product_scope.dart';

/// {@template category_screen}
/// CategoryScreen widget
/// {@endtemplate}
class CategoryScreen extends StatefulWidget {
  /// {@macro category_screen}
  const CategoryScreen({required this.categoryID, super.key});

  final CategoryID categoryID;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = ProductScope.getCategoryByID(context, widget.categoryID);
    return Scaffold(
      appBar: AppBar(
        title: Text(currentCategory.title),
        actions: CommonActions(),
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final categories = ProductScope.getCategories(context)
                .where((e) => e.parent == currentCategory.id)
                .toList(growable: false);
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemExtent: 60,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  key: ValueKey<CategoryID>(category.id),
                  title: Text(category.title),
                  onTap: () => throw UnimplementedError(), // GoRouter.of(context).goCategory(category.id),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
