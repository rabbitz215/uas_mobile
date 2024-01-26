// lib/screens/product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_galang_putra/screens/product_create_screen.dart';
import 'package:uas_galang_putra/screens/product_detail_screen.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UAS CRUD Product'),
      ),
      body: ListView.builder(
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          final product = productProvider.products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                productProvider.deleteProduct(product.id);
              },
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductCreateScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
