import 'package:flutter/material.dart';
import 'package:my_shop_provider/data/store_products.dart';
import 'package:my_shop_provider/providers/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = storeProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}


