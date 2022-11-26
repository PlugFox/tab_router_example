import 'dart:collection';

import 'package:go_router/go_router.dart';

import '../../feature/favorite/widget/favorite_screen.dart';
import '../../feature/product/model/category.dart';
import '../../feature/product/model/product.dart';
import '../../feature/product/widget/category_screen.dart';
import '../../feature/product/widget/product_screen.dart';
import '../../feature/product/widget/shop_screen.dart';
import '../../feature/profile/widget/profile_screen.dart';
import '../../feature/settings/widget/settings_screen.dart';
import '../widget/tabs_screen.dart';

/// TODO: custom routing

final List<RouteBase> $routes = <RouteBase>[
  // --- Tabs --- //

  ShellRoute(
    builder: (context, state, child) => TabsScreen(
      key: state.pageKey,
      child: child,
    ),
    routes: <GoRoute>[
      GoRoute(
        name: 'Favorite',
        path: '/favorite',
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        name: 'Shop',
        path: '/shop',
        builder: (context, state) => const ShopScreen(),
        routes: <RouteBase>[
          GoRoute(
            name: 'Category',
            path: 'category/:category',
            builder: (context, state) => CategoryScreen(categoryID: state.params['category'] ?? 'unknown'),
          ),
          GoRoute(
            name: 'Product',
            path: 'product/:product',
            builder: (context, state) => ProductScreen(productID: int.tryParse(state.params['product'] ?? '-1') ?? -1),
          ),
        ],
      ),
      GoRoute(
        name: 'Settings',
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  ),

  // --- Profile --- //

  GoRoute(
    name: 'Profile',
    path: '/profile',
    builder: (context, state) => const ProfileScreen(),
  ),

  // --- Redirecting & alias routes --- //
  GoRoute(
    name: 'Home',
    path: '/',
    redirect: (context, state) => '/shop',
  ),
];

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
