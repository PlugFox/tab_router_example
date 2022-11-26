import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/widgets.dart';

import '../data/product_controller.dart';
import '../data/product_repository.dart';
import '../model/category.dart';
import '../model/product.dart';

/// {@template product_scope}
/// ProductScope widget
/// {@endtemplate}
class ProductScope extends StatefulWidget {
  /// {@macro product_scope}
  const ProductScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  static void fetch(BuildContext context) => context.findAncestorStateOfType<_ProductScopeState>()!._controller.fetch();

  static List<CategoryEntity> getCategories(BuildContext context, {bool listen = true}) =>
      _InheritedCategory.maybeOf(context, listen: listen)?.categories ?? _notFoundInheritedWidgetOfExactType();

  static CategoryEntity getCategoryByID(BuildContext context, CategoryID id, {bool listen = true}) =>
      _InheritedCategory.getById(context, id, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  static List<ProductEntity> getProducts(BuildContext context, {bool listen = true}) =>
      _InheritedProduct.maybeOf(context, listen: listen)?.products ?? _notFoundInheritedWidgetOfExactType();

  static ProductEntity getProductByID(BuildContext context, ProductID id, {bool listen = true}) =>
      _InheritedProduct.getById(context, id, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedProductScope of the exact type',
        'out_of_scope',
      );

  @override
  State<ProductScope> createState() => _ProductScopeState();
}

class _ProductScopeState extends State<ProductScope> {
  late final ProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProductController(
      productRepository: ProductRepositoryImpl(),
    )..fetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => _InheritedCategory(
          categories: _controller.categories,
          child: _InheritedProduct(
            products: _controller.products,
            child: widget.child,
          ),
        ),
      );
}

class _InheritedCategory extends InheritedModel<CategoryID> {
  const _InheritedCategory({
    required this.categories,
    required super.child,
  });

  final List<CategoryEntity> categories;

  static _InheritedCategory? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedCategory>()
      : context.getElementForInheritedWidgetOfExactType<_InheritedCategory>()?.widget as _InheritedCategory?;

  static CategoryEntity? getById(BuildContext context, CategoryID id, {bool listen = true}) =>
      (listen ? InheritedModel.inheritFrom<_InheritedCategory>(context, aspect: id) : maybeOf(context, listen: false))
          ?.categories
          .firstWhereOrNull((e) => e.id == id);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedCategory oldWidget, Set<CategoryID> dependencies) {
    CategoryEntity? getAspect(List<CategoryEntity> list, CategoryID id) => list.firstWhereOrNull((e) => e.id == id);
    for (final id in dependencies) {
      if (getAspect(categories, id) != getAspect(oldWidget.categories, id)) return true;
    }
    return false;
  }

  @override
  bool updateShouldNotify(covariant _InheritedCategory oldWidget) =>
      !listEquals<CategoryEntity>(categories, oldWidget.categories);
}

class _InheritedProduct extends InheritedModel<ProductID> {
  const _InheritedProduct({
    required this.products,
    required super.child,
  });

  final List<ProductEntity> products;

  static _InheritedProduct? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedProduct>()
      : context.getElementForInheritedWidgetOfExactType<_InheritedProduct>()?.widget as _InheritedProduct?;

  static ProductEntity? getById(BuildContext context, ProductID id, {bool listen = true}) =>
      (listen ? InheritedModel.inheritFrom<_InheritedProduct>(context, aspect: id) : maybeOf(context, listen: false))
          ?.products
          .firstWhereOrNull((e) => e.id == id);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedProduct oldWidget, Set<ProductID> dependencies) {
    ProductEntity? getAspect(List<ProductEntity> list, ProductID id) => list.firstWhereOrNull((e) => e.id == id);
    for (final id in dependencies) {
      if (getAspect(products, id) != getAspect(oldWidget.products, id)) return true;
    }
    return false;
  }

  @override
  bool updateShouldNotify(covariant _InheritedProduct oldWidget) =>
      !listEquals<ProductEntity>(products, oldWidget.products);
}
