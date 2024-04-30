import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/cart.dart';
import 'package:my_shop_provider/utils/app_routes.dart';
import 'package:my_shop_provider/widgets/app_drawer.dart';
import 'package:my_shop_provider/widgets/badge_cart.dart';
import 'package:my_shop_provider/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FavoriteOptions { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Minha Loja'),
          actions: [
            PopupMenuButton(
              onSelected: (FavoriteOptions selectedFavorite) {
                setState(() {
                  if (selectedFavorite == FavoriteOptions.favorite) {
                    _showFavorite = true;
                  } else {
                    _showFavorite = false;
                  }
                });
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: FavoriteOptions.favorite,
                  child: Text('Favoritos'),
                ),
                const PopupMenuItem(
                  value: FavoriteOptions.all,
                  child: Text('Todos'),
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (context, cart, _) => BadgeCart(
                value: cart.itemCount.toString(),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.cartScreen);
                    
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ],
        ),
        body: ProductGrid(showFavorite: _showFavorite),
        drawer: const AppDrawer(),
      ),
    );
  }
}
