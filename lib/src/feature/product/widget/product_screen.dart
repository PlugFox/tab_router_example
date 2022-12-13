import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_router/tab_router.dart';

import '../../../common/widget/breadcrumbs.dart';
import '../../../common/widget/common_actions.dart';
import '../../favorite/widget/favorite_button.dart';
import '../model/product.dart';
import 'photo_view.dart';
import 'product_scope.dart';

/// {@template product_screen}
/// ProductScreen widget
/// {@endtemplate}
class ProductScreen extends StatelessWidget {
  /// {@macro product_screen}
  const ProductScreen({required this.productID, super.key});

  final String productID;

  @override
  Widget build(BuildContext context) {
    ProductEntity? product;
    try {
      final id = int.parse(productID);
      product = ProductScope.getProductByID(context, id);
    } on Object {
      log('Product `$productID` not found');
      product = null;
    }

    if (product == null) return const _ProductNotFound();

    final prevRoutes =
        AppRouter.of(context).state.tabs['shop']?.where((element) => element.name == 'category').toList() ??
            <NamedRouteSettings>[];
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: CommonActions(),
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
                      (state) => [],
                      tab: 'shop',
                      activate: true,
                    ),
                for (var i = 0; i < prevRoutes.length; i++)
                  Text(
                    ProductScope.getCategoryByID(context, prevRoutes[i].arguments['id']!).title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).primaryTextTheme.labelMedium,
                  ): () => AppRouter.of(context).navTab(
                        (state) => state.take(i + 1).toList(growable: false),
                        tab: 'shop',
                        activate: true,
                      ),
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(
                        color: Colors.black,
                      ),
                ): null,
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 256,
                child: Center(
                  child: ListView(
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shrinkWrap: true,
                    children: product.images
                        .map<Widget>(
                          (image) => Material(
                            color: Colors.grey[800],
                            child: InkWell(
                              onTap: () {
                                PhotoViewScreen.show(
                                  context,
                                  Hero(
                                    tag: 'product-image-$image',
                                    child: Image.asset(
                                      image,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                );
                                HapticFeedback.mediumImpact().ignore();
                              },
                              child: Hero(
                                tag: 'product-image-$image',
                                child: Image.asset(
                                  image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        )
                        .map<Widget>(
                          (child) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: child,
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                thickness: 1,
                indent: 16,
                endIndent: 16,
                height: 8,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FavoriteButton(product: product),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                thickness: 1,
                indent: 16,
                endIndent: 16,
                height: 8,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 4,
                  spacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    ProductProperty(title: 'Brand', value: product.brand),
                    ProductProperty(title: 'Rating', value: product.rating.toString()),
                    ProductProperty(title: 'Stock', value: product.stock.toString()),
                    ProductProperty(title: 'Price', value: product.price.toString()),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                thickness: 1,
                indent: 16,
                endIndent: 16,
                height: 8,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: 420,
                    child: Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductNotFound extends StatelessWidget {
  const _ProductNotFound();

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
                  Text(ProductScope.getCategoryByID(context, prevRoutes[i].arguments['id']!).title): () =>
                      AppRouter.of(context).navTab(
                        (state) => state.take(i + 1).toList(growable: false),
                        tab: 'shop',
                        activate: true,
                      ),
                const Text('Not found'): null,
              },
            ),
          ),
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Invalid product ID'),
        ),
      ),
    );
  }
}

class ProductProperty extends StatelessWidget {
  const ProductProperty({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 34,
        child: Chip(
          padding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          avatar: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              title[0],
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          label: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: '$title: ',
                ),
                TextSpan(
                  text: value,
                ),
              ],
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      );
}
