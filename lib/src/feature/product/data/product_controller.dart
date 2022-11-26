import 'dart:collection';

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
    notifyListeners();
  }
}
