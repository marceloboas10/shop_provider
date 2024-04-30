import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/cart.dart';
import 'package:my_shop_provider/providers/product_provider.dart';
import 'package:my_shop_provider/utils/app_routes.dart';
import 'package:my_shop_provider/views/cart_screen.dart';
import 'package:my_shop_provider/providers/orders.dart';
import 'package:my_shop_provider/views/orders_screen.dart';
import 'package:my_shop_provider/views/product_detail_screen.dart';
import 'package:my_shop_provider/views/product_overview_screen.dart';
import 'package:my_shop_provider/views/product_screen.dart';
import 'package:my_shop_provider/widgets/product_form_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(create: (_) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(centerTitle: true),
            primaryColor: Colors.purple,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: Colors.purple, secondary: Colors.deepOrange),
            useMaterial3: false,
            fontFamily: 'Lato'),
        home: const ProductOverviewScreen(),
        routes: {
          AppRoutes.home: (context) => const ProductOverviewScreen(),
          AppRoutes.productDetail: (context) => const ProductDetailScreen(),
          AppRoutes.cartScreen: (context) => const CartScreen(),
          AppRoutes.ordersScreen: (context) => const OrdersScreen(),
          AppRoutes.productScreen: (context) => const ProductScreen(),
          AppRoutes.productFormScreen:(context) => const ProductFormScreen(),
        },
      ),
    );
  }
}
