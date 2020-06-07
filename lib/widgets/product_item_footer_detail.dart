import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import "../providers/cart.dart";

class ProductItemFooterDetail extends StatelessWidget {
  const ProductItemFooterDetail({
    Key key,
    @required this.product,
    @required this.cart,
  }) : super(key: key);

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: (Theme.of(context).primaryColor).withOpacity(0.7),
      leading: Consumer<Product>(
        builder: (ctx, product, _) => IconButton(
          // We can add a child ( Where now it has a '_') here to make it a
          //complex object where child will not be rebuild
          //even if the this method is asked to rebuild from the provider method.
          icon: Icon(
            product.isFavorite ? Icons.favorite : Icons.favorite_border,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            product.toggleFavoriteStatus();
          },
        ),
      ),
      title: Text(
        product.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          cart.addItem(
            product.id,
            product.price,
            product.title,
          );
          Scaffold.of(context).hideCurrentSnackBar(); // to prevent bugs if a user rappidly hits the add to cart icon.
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Added ${product.title} to the Cart Successfuly!',
              ),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  cart.removeSingleItem(product.id);
                },
              ),
            ),
          );
        },
        color: Theme.of(context).accentColor,
      ),
    );
  }
}