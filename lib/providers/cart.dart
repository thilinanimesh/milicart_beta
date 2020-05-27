import 'package:MiliCart/widgets/cart_item.dart';
import 'package:flutter/foundation.dart';

import './cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CardItem> _items = {};

  Map<String, CardItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      //chnage quantity...
      _items.update(
        productId,
        (existingCardItem) => CardItem(
          id: existingCardItem.id,
          title: existingCardItem.title,
          price: existingCardItem.price,
          quantity: existingCardItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CardItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItemQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCardItem) => CardItem(
          id: existingCardItem.id,
          title: existingCardItem.title,
          price: existingCardItem.price,
          quantity: existingCardItem.quantity - 1,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(String productId){
    if(_items.containsKey(productId)){
      _items.remove(productId);
      notifyListeners();
    }
  }
}
