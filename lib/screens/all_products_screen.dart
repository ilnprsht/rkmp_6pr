import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_tile.dart';
import 'product_form_screen.dart';

class AllProductsScreen extends StatelessWidget {
  final bool embedInsideHome; // когда true — показываем без AppBar и с вложением в Home
  const AllProductsScreen({super.key, this.embedInsideHome = false});

  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final items = container.products;

    final list = items.isEmpty
        ? const EmptyState(message: 'Каталог пуст')
        : ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => ProductTile(product: items[i]),
    );

    if (embedInsideHome) {
      // без FAB, т.к. вкладка "Добавить" есть в BottomNavigationBar
      return Padding(padding: const EdgeInsets.only(top: 8), child: list);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Все товары')),
      body: list,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
