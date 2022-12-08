import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' hide Category;

import '../model/category.dart';
import '../model/product.dart';
import 'product_repository.dart';

class ProductController with ChangeNotifier {
  ProductController({required IProductRepository productRepository})
      : _productRepository = productRepository,
        _categories = <CategoryEntity>[],
        _products = <ProductEntity>[];
  final IProductRepository _productRepository;

  List<CategoryEntity> _categories;
  List<CategoryEntity> get categories => _categories;
  List<ProductEntity> _products;
  List<ProductEntity> get products => _products;

  Future<void> fetch() async {
    await Future.wait<void>(<Future<void>>[
      _productRepository
          .fetchCategories()
          .toList()
          .then<void>((value) => _categories = UnmodifiableListView<CategoryEntity>(value..sort())),
      _productRepository
          .fetchProducts()
          .toList()
          .then<void>((value) => _products = UnmodifiableListView<ProductEntity>(value..sort())),
    ]);
    _removeEmptyCategories();
    _removeEmptyRootCategories();
    for (final product in _products) {
      final category = _categories.firstWhereOrNull((e) => e.id == product.category);
      if (category == null) {
        print('Product ${product.id} has no category');
      }
    }
    notifyListeners();
  }

  void _removeEmptyCategories() => _categories = _categories.toList()
    ..removeWhere(
      (e) => !e.isRoot && _products.every((p) => p.category != e.id) && _categories.every((p) => p.parent != e.id),
    );

  void _removeEmptyRootCategories() => _categories = _categories.toList()
    ..removeWhere(
      (e) => e.isRoot && _products.every((p) => p.category != e.id) && _categories.every((p) => p.parent != e.id),
    );
}
