import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop_provider/providers/orders.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, this.order});

  final Order? order;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.order!.total!.toStringAsFixed(2)),
            subtitle:
                Text(DateFormat('dd/MM/yy hh:mm').format(widget.order!.date!)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                icon: Icon(
                    expanded == false ? Icons.expand_more : Icons.expand_less)),
          ),
          if (expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order!.products!.length * 25) + 10,
              child: ListView(
                children: widget.order!.products!
                    .map(
                      (product) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.title.toString()),
                          Text(
                              '${product.quantity.toString()} x R\$ ${product.price.toString()}'),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
