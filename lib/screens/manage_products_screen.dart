import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/manage_single_product_screen.dart';
import '../providers/products.dart';
import '../widgets/manage_product_item.dart';
import '../widgets/app_drawer.dart';

class ManageProductScreen extends StatelessWidget {
  static const routeName = '/manage-product-detail';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              //... to the new product screen
              Navigator.of(context)
                  .pushNamed(ManageSingleProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              ManageProductItem(
                productData.items[i].id,
                productData.items[i].title,
                productData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
