import 'package:flutter/material.dart';

import '../../../common/widget/common_actions.dart';
import '../model/product.dart';
import 'product_scope.dart';

/// {@template product_screen}
/// ProductScreen widget
/// {@endtemplate}
class ProductScreen extends StatelessWidget {
  /// {@macro product_screen}
  const ProductScreen({required this.productID, super.key});

  final ProductID productID;

  @override
  Widget build(BuildContext context) {
    final product = ProductScope.getProductByID(context, productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: CommonActions(),
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
                child: ListView(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: product.images
                      .map(Image.asset)
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: e,
                        ),
                      )
                      .toList(growable: false),
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
