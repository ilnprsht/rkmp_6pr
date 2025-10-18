import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../widgets/statistics_card.dart';
import 'all_products_screen.dart';
import 'favorites_screen.dart';
import 'product_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = ProductsContainer.of(context);

    final pages = <Widget>[
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              children: [
                StatisticsCard(
                  title: 'Всего',
                  value: state.totalCount.toString(),
                  icon: Icons.inventory_2,
                ),
                StatisticsCard(
                  title: 'Избранные',
                  value: state.favoritesCount.toString(),
                  icon: Icons.favorite,
                ),
                StatisticsCard(
                  title: 'Категории',
                  value: state.categoriesCount.toString(),
                  icon: Icons.category,
                ),
              ],
            ),
          ),
          const Expanded(child: AllProductsScreen(embedInsideHome: true)),
        ],
      ),
      const FavoritesScreen(),
      const ProductFormScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог косметической продукции'),
        centerTitle: true,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Все товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Добавить',
          ),
        ],
      ),
    );
  }
}
