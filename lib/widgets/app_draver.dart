import 'package:flutter/material.dart';
import 'package:my_shop_provider/utils/app_routes.dart';

class AppDraver extends StatelessWidget {
  const AppDraver({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shopify),
            title: const Text('Loja'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Pedidos'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.ordersScreen),
          )
        ],
      ),
    );
  }
}
