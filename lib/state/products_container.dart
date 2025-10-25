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
      name: 'MACximal Matte Lipstick Russian Red',
      brand: 'MAC',
      category: 'Декоративная',
      volume: '3.5 г',
      expirationDate: '08.2027',
      rating: 4.7,
      isFavorite: false,
      imageUrl: 'https://ir.ozone.ru/s3/multimedia-1-i/c1000/7038468774.jpg',
    ),
    Product(
      id: 2,
      name: 'Good Girl Gone Bad',
      brand: 'Killian',
      category: 'Парфюмерия',
      volume: '50 мл',
      expirationDate: '12.2028',
      rating: 5.0,
      isFavorite: true,
      imageUrl: 'https://www.letu.ru/common/img/pim/2025/10/EX_b9aa478d-31f8-495d-a424-e05b3952beae.jpg',
    ),
    Product(
      id: 3,
      name: 'Galac Niacin 2.0 essence',
      brand: 'Ma:Nyo',
      category: 'Уходовая',
      volume: '30 мл',
      expirationDate: '05.2026',
      rating: 4.7,
      isFavorite: false,
      imageUrl: 'https://premiumkorea.ru/upload/iblock/761/5572191dc9b1v7dfxm5omuknp15jiuc1.jpg',
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
      imageUrl: 'https://ir.ozone.ru/s3/multimedia-m/c1000/6641622850.jpg',
    ),
    Product(
      id: 5,
      name: 'Crystal Tint 01 Vintage Apple',
      brand: 'Clio',
      category: 'Декоративная',
      volume: '3.4 г',
      expirationDate: '10.2028',
      rating: 4.9,
      isFavorite: false,
      imageUrl: 'https://pcdn.goldapple.ru/p/p/19000197603/imgmain.jpg',
    ),
    Product(
      id: 6,
      name: 'Perfect Sculptor',
      brand: 'SHIKSTUDIO',
      category: 'Декоративная',
      volume: '8 г',
      expirationDate: '02.2027',
      rating: 4.4,
      isFavorite: false,
      imageUrl: 'https://749923.selcdn.ru/shikstore/img/products/1245/1721721980669f647ca6a198.32803669_1080_1520_inset.jpg',
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
