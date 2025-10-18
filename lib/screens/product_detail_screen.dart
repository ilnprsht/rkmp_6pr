import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/products_container.dart';
import '../widgets/product_card.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  Future<void> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить запись?'),
        content: Text('Товар «${product.name}» будет удалён из каталога.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Отмена')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Удалить')),
        ],
      ),
    );
    if (result == true) {
      ProductsContainer.of(context).deleteProduct(product.id);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ProductsContainer.of(context);
    final current = state.products.firstWhere((p) => p.id == product.id,
        orElse: () => product);

    return Scaffold(
      appBar: AppBar(title: const Text('Информация о товаре')),
      body: SingleChildScrollView(
        child: ProductCard(
          product: current,
          onToggleFavorite: () => state.toggleFavorite(current.id),
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductFormScreen(editing: current)),
            );
          },
          onDelete: () => _confirmDelete(context),
        ),
      ),
    );
  }
}
