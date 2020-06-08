//Native
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//Screens
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/manage_products_screen.dart';
import './screens/manage_single_product_screen.dart';
//Providers
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(Milicart());

class Milicart extends StatelessWidget {
  static const primaryColor = const Color(0xff3ec2a6);
  static const secondaryColor = const Color(0xff7ad5c2);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MiliCart',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ManageProductScreen.routeName: (ctx) => ManageProductScreen(),
          ManageSingleProductScreen.routeName: (ctx) => ManageSingleProductScreen(),
        },
      ),
    );
  }
}