import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: product.imageUrl == ''
                  ? Image.asset('assets/image/semFoto.png')
                  : Image.network(
                      product.imageUrl.toString(),
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'R\$ ${product.price!.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(product.description.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
