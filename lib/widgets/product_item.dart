import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/product.dart';
import 'package:my_shop_provider/providers/product_provider.dart';
import 'package:my_shop_provider/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: product.imageUrl == ''
              ? Image.asset(
                  'assets/image/semFoto.png',
                  fit: BoxFit.cover,
                )
              : Image.network(
                  product.imageUrl.toString(),
                ),
        ),
        title: Text(product.title.toString()),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.productFormScreen, arguments: product);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Excluir Produto'),
                        content: Text(
                            'Tem certeza que deseja excluir o produto ${product.title}?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('NAO')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .deleteProduct(product);
                              },
                              child: const Text('SIM'))
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
