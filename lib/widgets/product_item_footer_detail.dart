import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';


class ProductItemFooterDetail extends StatelessWidget {
  const ProductItemFooterDetail({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
      leading: Consumer<Product>(
        builder: (ctx, product, child) => IconButton(
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
        onPressed: () {},
        color: Theme.of(context).accentColor,
      ),
    );
  }
}