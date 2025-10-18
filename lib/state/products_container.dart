import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsContainer extends StatefulWidget {
  final Widget child;
  const ProductsContainer({super.key, required this.child});

  static _ProductsContainerState of(BuildContext context) {
    final state = context.findAncestorStateOfType<_ProductsContainerState>();
    assert(state != null, 'ProductsContainer.of(context) not found in tree');
    return state!;
  }

  @override
  State<ProductsContainer> createState() => _ProductsContainerState();
}

class _ProductsContainerState extends State<ProductsContainer> {
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Lait-Crème Concentré',
      brand: 'Embryolisse',
      category: 'Уходовая',
      volume: '75 мл',
      expirationDate: '08.2027',
      rating: 4.5,
      isFavorite: false,
    ),
    Product(
      id: 2,
      name: 'Chance Eau Tendre',
      brand: 'Chanel',
      category: 'Парфюмерия',
      volume: '50 мл',
      expirationDate: '12.2028',
      rating: 4.8,
      isFavorite: true,
    ),
    Product(
      id: 3,
      name: 'Better Than Sex',
      brand: 'Too Faced',
      category: 'Декоративная',
      volume: '8 мл',
      expirationDate: '05.2026',
      rating: 4.2,
      isFavorite: false,
    ),
  ];

  int _nextId = 4;

  List<Product> get products => List.unmodifiable(_products);

  void addProduct(Product product) {
    setState(() {
      _products.add(product.copyWith(id: _nextId++));
    });
  }

  void updateProduct(Product updated) {
    setState(() {
      final index = _products.indexWhere((p) => p.id == updated.id);
      if (index != -1) _products[index] = updated;
    });
  }

  void deleteProduct(int id) {
    setState(() {
      _products.removeWhere((p) => p.id == id);
    });
  }

  void toggleFavorite(int id) {
    setState(() {
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        final p = _products[index];
        _products[index] = p.copyWith(isFavorite: !p.isFavorite);
      }
    });
  }

  List<Product> getFavorites() => _products.where((p) => p.isFavorite).toList();

  // статистика для главной страницы
  int get totalCount => _products.length;
  int get favoritesCount => _products.where((p) => p.isFavorite).length;
  int get categoriesCount =>
      _products.map((p) => p.category).toSet().length;

  @override
  Widget build(BuildContext context) => widget.child;
}
