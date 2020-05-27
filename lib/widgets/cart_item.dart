import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './circle_image.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    @required this.productId,
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  );

  String uri = 'https://www.woolha.com/media/2019/06/buneary.jpg';
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        //Change this leter to milicart accent color
        color: Colors.orange,
        child: Icon(
          Icons.delete_sweep,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      secondaryBackground: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.remove_shopping_cart,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction:
          DismissDirection.endToStart, // this will block the swap left for now.
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          //this need to be implimented later stage, not working as expected, widget tree isn't updating

          //Provider.of<Cart>(context).removeItemQuantity(productId);
          //print('Deleting product qty');
        } else {
          //print('Deleting the whole product');
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              // fill it with the product image later
              child: CircleImage(uri),
            ),
            title: Text(title),
            subtitle: Row(
              children: <Widget>[
                Text('$quantity x'),
                Chip(
                  label: Text('\$$price'),
                ),
              ],
            ),
            trailing: Text('Total: \$${(price * quantity)}'),
          ),
        ),
      ),
    );
  }
}
