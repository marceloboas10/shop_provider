import 'package:flutter/material.dart';

import 'package:my_shop_provider/widgets/app_draver.dart';
import 'package:my_shop_provider/widgets/order_widget.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido'),
      ),
      drawer: const AppDraver(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, i) => OrderWidget(
          order: orders.items[i],
        ),
      ),
    );
  }
}
