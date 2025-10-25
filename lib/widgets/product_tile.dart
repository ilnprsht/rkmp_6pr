import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ✅
import '../models/product.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_form_screen.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;

  const ProductTile({
    super.key,
    required this.product,
    required this.onToggleFavorite,
    required this.onDelete,
  });

  Future<void> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить запись?'),
        content: Text('Товар «${product.name}» будет удалён из каталога.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (result == true) onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        leading: (product.imageUrl != null && product.imageUrl!.isNotEmpty)
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: product.imageUrl!,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            placeholder: (_, __) => const SizedBox(
              width: 56,
              height: 56,
              child:
              Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            errorWidget: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 32),
          ),
        )
            : const Icon(Icons.image_not_supported, size: 32),

        title: Text('${product.name} • ${product.brand}'),
        subtitle: Text(
          '${product.category} • ${product.volume} • ★ ${product.rating.toStringAsFixed(1)}',
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },

        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              tooltip: 'Избранное',
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: product.isFavorite ? Colors.pinkAccent : null,
              ),
              onPressed: onToggleFavorite,
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
