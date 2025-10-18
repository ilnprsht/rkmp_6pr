import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_tile.dart';
import 'product_form_screen.dart';

class AllProductsScreen extends StatefulWidget {
  final bool embedInsideHome;
  const AllProductsScreen({super.key, this.embedInsideHome = false});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final items = container.products;

    final list = items.isEmpty
        ? const EmptyState(message: 'Каталог пуст')
        : ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) {
        final p = items[i];
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
    );

    if (widget.embedInsideHome) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: list,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Все товары')),
      body: list,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProductFormScreen(),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
