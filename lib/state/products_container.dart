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
      imageUrl: 'https://picsum.photos/id/1011/600/600',
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
      imageUrl: 'https://picsum.photos/id/1025/600/600',
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
      imageUrl: 'https://picsum.photos/id/100/600/600',
    ),
    Product(
      id: 4,
      name: 'Advanced Night Repair',
      brand: 'Estée Lauder',
      category: 'Уходовая',
      volume: '30 мл',
      expirationDate: '03.2027',
      rating: 4.7,
      isFavorite: false,
      imageUrl: 'https://picsum.photos/id/433/600/600',
    ),
    Product(
      id: 5,
      name: 'La Vie Est Belle',
      brand: 'Lancôme',
      category: 'Парфюмерия',
      volume: '75 мл',
      expirationDate: '10.2028',
      rating: 4.6,
      isFavorite: false,
      imageUrl: 'https://picsum.photos/id/318/600/600',
    ),
    // при желании можно добавить ещё
    Product(
      id: 6,
      name: 'Teint Idole Ultra Wear',
      brand: 'Lancôme',
      category: 'Декоративная',
      volume: '30 мл',
      expirationDate: '02.2027',
      rating: 4.4,
      isFavorite: false,
      imageUrl: 'https://picsum.photos/id/237/600/600',
    ),
  ];

  int _nextId = 7;

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

  @override
  Widget build(BuildContext context) => widget.child;
}
