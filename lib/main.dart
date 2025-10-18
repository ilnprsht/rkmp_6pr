import 'package:flutter/material.dart';
import 'state/products_container.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductsContainer(          // ✅ обязательно оборачивает всё приложение
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Каталог косметики',
        theme: ThemeData(
          colorSchemeSeed: Colors.pinkAccent,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
