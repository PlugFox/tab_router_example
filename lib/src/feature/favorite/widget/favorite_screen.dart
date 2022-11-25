import 'package:flutter/material.dart';

import '../../../common/widget/common_actions.dart';

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
            child: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: <Widget>[
                  ListTile(
                    title: const Center(child: Text('Item 1')),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Center(child: Text('Item 2')),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Center(child: Text('Item 3')),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Center(child: Text('Item 4')),
                    onTap: () {},
                  ),
                ],
              ).toList(),
            ),
          ),
        ),
      );
}
