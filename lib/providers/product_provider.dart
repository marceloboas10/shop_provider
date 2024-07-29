import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop_provider/providers/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = [];
  final String _baseUrl =
      'https://cod3rbr-default-rtdb.firebaseio.com/produtcts';

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
    final response = await http.get(Uri.parse('$_baseUrl.json'));
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
    final response = await http.post(Uri.parse('$_baseUrl.json'),
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

  Future<void> updateProduct(Product product) async {
    if (product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      await http.patch(Uri.parse('$_baseUrl/${product.id}.json'),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response =
          await http.delete(Uri.parse('$_baseUrl/${product.id}.json'));

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw const HttpException('Ocorre um erro ao excluir o produto!');
      }
    }
  }
}
