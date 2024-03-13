import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/cart.dart';
import 'package:my_shop_provider/providers/product_provider.dart';
import 'package:my_shop_provider/utils/app_routes.dart';
import 'package:my_shop_provider/views/product_detail_screen.dart';
import 'package:my_shop_provider/views/product_overview_screen.dart';
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
          AppRoutes.productDetail: (context) => const ProductDetailScreen(),
        },
      ),
    );
  }
}