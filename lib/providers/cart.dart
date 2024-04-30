import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/product.dart';

class CartItem {
  final String? id;
  final String? productId;
  final String? title;
  final int? quantity;
  final double? price;

  CartItem({
    required this.id,
    required this.productId,
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

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartTotal) {
      total += cartTotal.price! * cartTotal.quantity!;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (existItem) {
        return CartItem(
            id: existItem.id,
            productId: product.id,
            title: existItem.title,
            quantity: existItem.quantity! + 1,
            price: existItem.price);
      });
    } else {
      _items.putIfAbsent(
          product.id!,
          () => CartItem(
              id: Random().nextDouble().toString(),
              productId: product.id,
              title: product.title,
              quantity: 1,
              price: product.price));
    }
    notifyListeners();
  }

  void removeSingleItem(produtId) {
    if (!_items.containsKey(produtId)) {
      return;
    }

    if (_items[produtId]!.quantity == 1) {
      _items.remove(produtId);
    } else {
      _items.update(produtId, (existItem) {
        return CartItem(
            id: existItem.id,
            productId: existItem.productId,
            title: existItem.title,
            quantity: existItem.quantity! - 1,
            price: existItem.price);
      });
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
