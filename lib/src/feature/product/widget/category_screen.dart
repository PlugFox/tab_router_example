import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_router/tab_router.dart';

import '../../../common/widget/breadcrumbs.dart';
import '../../../common/widget/common_actions.dart';
import '../model/category.dart';
import '../model/product.dart';
import 'product_scope.dart';

/// {@template category_screen}
/// CategoryScreen widget
/// {@endtemplate}
class CategoryScreen extends StatelessWidget {
  /// {@macro category_screen}
  const CategoryScreen({required this.categoryID, super.key});

  final CategoryID categoryID;

  @override
  Widget build(BuildContext context) {
    final CategoryEntity currentCategory;
    try {
      currentCategory = ProductScope.getCategoryByID(context, categoryID);
    } on Object {
      log('Category `$categoryID` not found');
      return const _CategoryNotFound();
    }

    final categories =
        ProductScope.getCategories(context).where((e) => e.parent == currentCategory.id).toList(growable: false);
    final products =
        ProductScope.getProducts(context).where((e) => e.category == currentCategory.id).toList(growable: false);
    final prevRoutes =
        AppRouter.of(context).state.tabs['shop']?.where((element) => element.name == 'category').toList() ??
            <NamedRouteSettings>[];

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // --- App bar --- //

          SliverAppBar(
            title: Text(currentCategory.title),
            actions: CommonActions(),
            pinned: false,
            floating: true,
            snap: true,
            forceElevated: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: SizedBox(
                height: 48,
                child: Breadcrumbs(
                  breadcrumbs: <Widget, VoidCallback?>{
                    Text(
                      'Shop',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).primaryTextTheme.labelMedium,
                    ): () => AppRouter.of(context).navTab(
                          (_) => [],
                          tab: 'shop',
                          activate: true,
                        ),
                    for (var i = 0; i < prevRoutes.length; i++)
                      Text(
                        ProductScope.getCategoryByID(context, prevRoutes[i].arguments['id']!).title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(
                              color: prevRoutes.length - 1 == i ? Colors.black : null,
                            ),
                      ): prevRoutes.length - 1 == i
                          ? null
                          : () => AppRouter.of(context).navTab(
                                (state) => state.take(i + 1).toList(growable: false),
                                tab: 'shop',
                                activate: true,
                              ),
                  },
                ),
              ),
            ),
          ),

          // --- Categories --- //

          if (categories.isNotEmpty) ...<Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 60,
              delegate: SliverChildBuilderDelegate(
                childCount: categories.length,
                (context, index) {
                  final category = categories[index];
                  return ListTile(
                    key: ValueKey<CategoryID>(category.id),
                    title: Text(category.title),
                    onTap: () {
                      AppRouter.of(context).pushTab(
                        'category',
                        arguments: <String, String>{'id': category.id},
                      );
                      HapticFeedback.mediumImpact().ignore();
                    },
                  );
                },
              ),
            ),
          ],

          // --- Divider --- //

          if (products.isNotEmpty && categories.isNotEmpty) ...<Widget>[
            const SliverToBoxAdapter(
              child: Divider(height: 16),
            ),
          ],

          // --- Products --- //

          if (products.isNotEmpty) ...<Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Products',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 160,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    key: ValueKey<ProductID>(product.id),
                    elevation: 8,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Material(
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Ink.image(
                                      image: AssetImage(product.thumbnail),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: SizedBox(
                                      height: 28,
                                      child: Center(
                                        child: Text(
                                          product.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.labelLarge,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: SizedBox(
                                      height: 40,
                                      child: Text(
                                        product.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: InkWell(
                                onTap: () {
                                  AppRouter.of(context).pushTab(
                                    'product',
                                    arguments: <String, String>{'id': product.id.toString()},
                                  );
                                  HapticFeedback.mediumImpact().ignore();
                                },
                                splashColor: Theme.of(context).splashColor,
                                borderRadius: BorderRadius.circular(16),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryNotFound extends StatelessWidget {
  const _CategoryNotFound();

  @override
  Widget build(BuildContext context) {
    final prevRoutes =
        AppRouter.of(context).state.tabs['shop']?.where((element) => element.name == 'category').toList() ??
            <NamedRouteSettings>[];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not found', maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: CommonActions(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SizedBox(
            height: 48,
            child: Breadcrumbs(
              breadcrumbs: <Widget, VoidCallback?>{
                const Text('Shop'): () => AppRouter.of(context).navTab(
                      (state) => [],
                      tab: 'shop',
                      activate: true,
                    ),
                for (var i = 0; i < prevRoutes.length; i++)
                  Text(ProductScope.getCategoryByID(context, prevRoutes[i].arguments['id']!).title):
                      prevRoutes.length - 1 == i
                          ? null
                          : () => AppRouter.of(context).navTab(
                                (state) => state.take(i + 1).toList(growable: false),
                                tab: 'shop',
                                activate: true,
                              ),
              },
            ),
          ),
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Invalid category ID'),
        ),
      ),
    );
  }
}
