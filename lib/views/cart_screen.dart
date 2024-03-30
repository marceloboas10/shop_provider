import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/cart.dart';
import 'package:my_shop_provider/providers/orders.dart';
import 'package:my_shop_provider/utils/app_routes.dart';
import 'package:my_shop_provider/widgets/cart_product.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItem = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, i) => CartProduct(
                cartItem: cartItem[i],
                count: i,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 25, right: 25),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<Orders>(context, listen: false).addOrder(cart);
                cart.clear();
                Navigator.of(context).pushNamed(AppRoutes.ordersScreen);
              },
              style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size(MediaQuery.sizeOf(context).width, 50),
                ),
              ),
              child: const Text('COMPRAR'),
            ),
          ),
        ],
      ),
    );
  }
}
