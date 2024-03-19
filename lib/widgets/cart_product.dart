import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/cart.dart';
import 'package:my_shop_provider/providers/product.dart';
import 'package:my_shop_provider/providers/product_provider.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key, required this.cartItem, required this.count});

  final CartItem cartItem;
  final int count;

  @override
  Widget build(BuildContext context) {
    final List<Product> product = Provider.of<ProductProvider>(context).items;

    return Dismissible(
      key: ValueKey(cartItem.id),
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false)
            .removeItem(cartItem.productId.toString());
      },
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, i) =>
                  Image.network(product[count].imageUrl.toString()),
            )),
            title: Text(cartItem.title.toString()),
            subtitle:
                Text('Total: R\$ ${cartItem.price! * cartItem.quantity!}'),
            trailing: Text('${cartItem.quantity}'),
          ),
        ),
      ),
    );
  }
}
