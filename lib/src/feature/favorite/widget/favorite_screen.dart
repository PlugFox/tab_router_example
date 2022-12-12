import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_router/tab_router.dart';

import '../../../common/widget/common_actions.dart';
import 'favorite_scope.dart';

/// {@template favorite_screen}
/// FavoriteScreen widget
/// {@endtemplate}
class FavoriteScreen extends StatelessWidget {
  /// {@macro favorite_screen}
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
          actions: CommonActions(),
        ),
        body: SafeArea(
          child: Center(
            child: Builder(
              builder: (context) {
                final favorites = FavoriteScope.of(context);
                return ListView.separated(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];
                    return ListTile(
                      title: Text(product.title),
                      onTap: () {
                        AppRouter.of(context).navTab(
                          (routes) => <RouteSettings>[
                            if (product.category.isNotEmpty)
                              NamedRouteSettings(
                                name: 'category',
                                arguments: <String, String>{'id': product.category},
                              ),
                            NamedRouteSettings(
                              name: 'product',
                              arguments: <String, String>{'id': product.id.toString()},
                            ),
                          ],
                          tab: 'shop',
                          activate: true,
                        );
                        HapticFeedback.mediumImpact().ignore();
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete'),
                            content: Text('Are you sure you want to delete "${product.title}" from favorites?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  HapticFeedback.selectionClick().ignore();
                                },
                                child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  FavoriteScope.remove(context, product.id);
                                  Navigator.of(context).pop();
                                  HapticFeedback.mediumImpact().ignore();
                                },
                                child: const Text('DELETE'),
                              ),
                            ],
                          ),
                        ).ignore(),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                  ),
                );
              },
            ),
          ),
        ),
      );
}
