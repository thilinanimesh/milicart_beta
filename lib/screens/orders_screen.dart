import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart' as wi;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
    static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),      
      body: ListView.builder(
        itemBuilder: (ctx, i) => wi.OrderItem(orderData.orders[i]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}