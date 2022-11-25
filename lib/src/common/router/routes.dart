import 'dart:collection';

import 'package:go_router/go_router.dart';

import '../../feature/favorite/widget/favorite_screen.dart';
import '../../feature/profile/widget/profile_screen.dart';
import '../../feature/settings/widget/settings_screen.dart';
import '../../feature/shop/widget/shop_screen.dart';
import '../widget/tabs_screen.dart';

final List<RouteBase> $routes = <RouteBase>[
  // --- Tabs --- //

  ShellRoute(
    builder: (context, state, child) => TabsScreen(child: child),
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
