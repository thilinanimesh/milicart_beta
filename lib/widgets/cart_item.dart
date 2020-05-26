import 'package:flutter/material.dart';

import './circle_image.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  );

  String uri = 'https://www.woolha.com/media/2019/06/buneary.jpg';
  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
