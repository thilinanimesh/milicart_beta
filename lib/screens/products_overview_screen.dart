import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions{
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MiliCart'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              print(selectedValue);
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favourites'), value:FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value:FilterOptions.All),
            ],
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
