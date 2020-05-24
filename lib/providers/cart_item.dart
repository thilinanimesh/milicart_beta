import 'package:flutter/material.dart';

class CardItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CardItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}
