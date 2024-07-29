import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/product_provider.dart';
import 'package:my_shop_provider/utils/app_routes.dart';
import 'package:my_shop_provider/widgets/app_drawer.dart';
import 'package:my_shop_provider/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  Future<void> _refreshScreen(BuildContext context) async {
    Provider.of<ProductProvider>(context,listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productFormScreen);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshScreen(context),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: products.itensCount,
          itemBuilder: (ctx, i) => ProductItem(
            product: products.items[i],
          ),
        ),
      ),
    );
  }
}
