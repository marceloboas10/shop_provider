import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop_provider/providers/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = [];
  final String _url =
      'https://cod3rbr-default-rtdb.firebaseio.com/produtcts.json';

  List<Product> get items {
    return [..._items];
  }

  int get itensCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse(_url));
    _items.clear();
    try {
      Map<String, dynamic> data = json.decode(response.body);

      data.forEach((productId, productData) {
        _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      notifyListeners();
    } catch (e) {
      e;
    }

    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(Uri.parse(_url),
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
          'isFavorite': newProduct.isFavorite
        }));

    _items.add(Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(Product product) {
    if (product.id == null) {
      return;
    }

    _items.remove(product);
    notifyListeners();
  }
}
