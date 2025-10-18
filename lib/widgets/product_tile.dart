import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/products_container.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_form_screen.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  Future<void> _confirmDelete(BuildContext context) async {
    final container = ProductsContainer.of(context);
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
      container.deleteProduct(product.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        title: Text('${product.name} • ${product.brand}'),
        subtitle: Text('${product.category} • ${product.volume} • ★ ${product.rating.toStringAsFixed(1)}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
          );
        },
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              tooltip: 'Избранное',
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () => container.toggleFavorite(product.id),
            ),
            IconButton(
              tooltip: 'Редактировать',
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductFormScreen(editing: product),
                  ),
                );
              },
            ),
            IconButton(
              tooltip: 'Удалить',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
      ),
    );
  }
}
