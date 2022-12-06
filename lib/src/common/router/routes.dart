import 'package:flutter/widgets.dart';

import '../../feature/favorite/widget/favorite_screen.dart';
import '../../feature/product/widget/category_screen.dart';
import '../../feature/product/widget/product_screen.dart';
import '../../feature/product/widget/shop_screen.dart';
import '../../feature/profile/widget/profile_screen.dart';
import '../../feature/settings/widget/settings_screen.dart';
import 'adaptive_page.dart';

typedef NamedPageBuilder = Page<Object?> Function(BuildContext context, Map<String, String> arguments);

/* Name: PageBuilder */
final Map<String, NamedPageBuilder> $routes = <String, NamedPageBuilder>{
  'favorite': (context, arguments) => AdaptivePage(
        name: 'Favorite',
        builder: (context) => const FavoriteScreen(),
      ),
  'shop': (context, arguments) => AdaptivePage(
        name: 'Shop',
        builder: (context) => const ShopScreen(),
      ),
  'category': (context, arguments) => AdaptivePage(
        name: 'Category',
        builder: (context) => CategoryScreen(categoryID: arguments['id'] ?? 'unknown'),
      ),
  'product': (context, arguments) => AdaptivePage(
        name: 'Product',
        builder: (context) => ProductScreen(productID: int.tryParse(arguments['id'] ?? '-1') ?? -1),
      ),
  'settings': (context, arguments) => AdaptivePage(
        name: 'Settings',
        builder: (context) => const SettingsScreen(),
      ),
  'profile': (context, arguments) => AdaptivePage(
        name: 'Profile',
        builder: (context) => const ProfileScreen(),
      ),
};
