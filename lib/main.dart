import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/product_list_screen.dart';
import 'providers/product_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider()..fetchProducts(),
      child: MaterialApp(
        title: 'Product CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<ProductProvider>(
          builder: (context, productProvider, _) => const ProductListScreen(),
        ),
      ),
    );
  }
}
