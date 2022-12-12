import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../common/util/storage.dart';
import '../../product/model/product.dart';
import '../../product/widget/product_scope.dart';

/// {@template favorite_scope}
/// FavoriteScope widget
/// {@endtemplate}
class FavoriteScope extends StatefulWidget {
  /// {@macro favorite_scope}
  const FavoriteScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `FavoriteScope.maybeOf(context)`
  static List<ProductEntity>? maybeOf(BuildContext context, {bool listen = true}) =>
      _InheritedFavoriteScope.maybeOf(context, listen: listen)?.products;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a FavoriteScope of the exact type',
        'out_of_scope',
      );

  static void add(BuildContext context, ProductID id) =>
      _InheritedFavoriteScope.maybeOf(context, listen: false)?.state.addProduct(id);

  static void remove(BuildContext context, ProductID id) =>
      _InheritedFavoriteScope.maybeOf(context, listen: false)?.state.removeProduct(id);

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `FavoriteScope.of(context)`
  static List<ProductEntity> of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  State<FavoriteScope> createState() => _FavoriteScopeState();
}

class _FavoriteScopeState extends State<FavoriteScope> {
  static const _$key = 'favorites';
  List<ProductEntity> products = <ProductEntity>[];

  void addProduct(ProductID id) {
    try {
      products = <ProductEntity>{...products, ProductScope.getProductByID(context, id, listen: false)}.toList()..sort();
    } on Object {
      log('Product not found: $id');
    }
    setState(() => $storage.setStringList(_$key, products.map<String>((e) => e.id.toString()).toList()).ignore());
  }

  void removeProduct(ProductID id) {
    products = List<ProductEntity>.of(products)..removeWhere((p) => p.id == id);
    setState(() => $storage.setStringList(_$key, products.map<String>((e) => e.id.toString()).toList()).ignore());
  }

  void refresh() {
    final ids = $storage.getStringList(_$key)?.map<ProductID?>(int.tryParse).whereType<ProductID>().toSet() ??
        <ProductEntity>{};
    final all = ProductScope.getProducts(context, listen: true);
    products = ids
        .map<ProductEntity?>((id) => all.firstWhereOrNull((p) => p.id == id))
        .whereType<ProductEntity>()
        .toList()
      ..sort();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refresh();
  }

  @override
  Widget build(BuildContext context) => _InheritedFavoriteScope(
        products: products,
        state: this,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree
class _InheritedFavoriteScope extends InheritedWidget {
  const _InheritedFavoriteScope({
    required this.products,
    required this.state,
    required super.child,
  });

  final List<ProductEntity> products;
  final _FavoriteScopeState state;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `_InheritedFavoriteScope.maybeOf(context)`
  static _InheritedFavoriteScope? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedFavoriteScope>()
      : context.getElementForInheritedWidgetOfExactType<_InheritedFavoriteScope>()?.widget as _InheritedFavoriteScope?;

  @override
  bool updateShouldNotify(covariant _InheritedFavoriteScope oldWidget) =>
      !listEquals<ProductEntity>(products, oldWidget.products);
}
