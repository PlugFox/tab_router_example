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
        builder: (context) => CategoryScreen(categoryID: arguments['category'] ?? 'unknown'),
      ),
  'product': (context, arguments) => AdaptivePage(
        name: 'Product',
        builder: (context) => ProductScreen(productID: int.tryParse(arguments['product'] ?? '-1') ?? -1),
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

/*
extension $GoRouterExtension on GoRouter {
  Uri get uri => Uri.parse(location);
  Map<String, String> get queryParams => UnmodifiableMapView<String, String>(uri.queryParameters);

  void goHome() => go('/');

  void goFavorite() => goNamed('Favorite');

  void goShop() => goNamed('Shop');

  void goCategory(CategoryID id) => pushNamed('Category', params: <String, String>{'category': id});

  void goProduct(ProductID id) => pushNamed('Product', params: <String, String>{'product': id.toString()});

  void goSettings() => goNamed('Settings');

  void goProfile() => goNamed('Profile');
}

extension $GoRouterStateExtension on GoRouterState {
  Uri get uri => Uri.parse(location);
}

abstract class AppRouter {
  // TODO: make this with reflection on GoRouter and GoRouterState
  factory AppRouter.instance() => throw UnimplementedError(); // _$GoAppRouter();
}
*/
