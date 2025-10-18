import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onToggleFavorite;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onToggleFavorite,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Бренд: ${product.brand}'),
            Text('Категория: ${product.category}'),
            Text('Объём: ${product.volume}'),
            Text('Срок годности: ${product.expirationDate}'),
            Text('Рейтинг: ★ ${product.rating.toStringAsFixed(1)}'),
            const Divider(height: 24),
            Row(
              children: [
                IconButton(
                  tooltip: 'Избранное',
                  icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: onToggleFavorite,
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Удалить'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
