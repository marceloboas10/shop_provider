import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/product.dart';

class CartItem {
  final String? id;
  final String? title;
  final int? quantity;
  final double? price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (existItem) {
        return CartItem(
            id: existItem.id,
            title: existItem.title,
            quantity: existItem.quantity! + 1,
            price: existItem.price);
      });
    } else {
      _items.putIfAbsent(
          product.id!,
          () => CartItem(
              id: Random().nextDouble().toString(),
              title: product.title,
              quantity: 1,
              price: product.price));
    }
    notifyListeners();
  }
}
