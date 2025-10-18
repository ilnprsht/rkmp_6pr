import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final favs = container.getFavorites();

    return Scaffold(
      appBar: AppBar(title: const Text('Избранные')),
      body: favs.isEmpty
          ? const EmptyState(message: 'В избранном пока нет товаров')
          : ListView.builder(
        itemCount: favs.length,
        itemBuilder: (_, i) => ProductTile(product: favs[i]),
      ),
    );
  }
}
