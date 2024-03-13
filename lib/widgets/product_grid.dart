import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/product.dart';
import 'package:my_shop_provider/providers/product_provider.dart';
import 'package:my_shop_provider/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.showFavorite});

  final bool showFavorite;

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts = showFavorite
        ? Provider.of<ProductProvider>(context).favoriteItems
        : Provider.of<ProductProvider>(context).items;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: loadedProducts[i], child: const ProductItem()),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
