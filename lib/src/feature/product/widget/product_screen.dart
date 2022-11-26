import 'package:flutter/material.dart';

import '../../../common/widget/common_actions.dart';
import '../model/product.dart';

/// {@template product_screen}
/// ProductScreen widget
/// {@endtemplate}
class ProductScreen extends StatelessWidget {
  /// {@macro product_screen}
  const ProductScreen({required this.productID, super.key});

  final ProductID productID;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
          actions: CommonActions(),
        ),
        body: const SafeArea(
          child: Center(
            child: Text('Product'),
          ),
        ),
      );
}
