import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_tile.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final favorites = container.getFavorites();

    return Scaffold(
      appBar: AppBar(title: const Text('Избранные товары')),
      body: favorites.isEmpty
          ? const EmptyState(message: 'В избранном пока нет товаров')
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (_, i) {
          final p = favorites[i];
          return ProductTile(
            product: p,
            onToggleFavorite: () {
              container.toggleFavorite(p.id);
              setState(() {});
            },
            onDelete: () {
              container.deleteProduct(p.id);
              setState(() {});
            },
          );
        },
      ),
    );
  }
}


