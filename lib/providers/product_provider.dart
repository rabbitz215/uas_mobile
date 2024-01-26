// lib/providers/product_provider.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? productsJson = prefs.getStringList('products');

    if (productsJson != null) {
      _products = productsJson
          .map((json) => Product.fromJson(jsonDecode(json)))
          .toList();
    }

    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    _products.add(product);
    await _saveProducts();
  }

  Future<void> updateProduct(Product product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      await _saveProducts();
    }
  }

  Future<void> deleteProduct(int id) async {
    _products.removeWhere((p) => p.id == id);
    await _saveProducts();
  }

  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productsJson =
        _products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList('products', productsJson);
    notifyListeners();
  }
}
