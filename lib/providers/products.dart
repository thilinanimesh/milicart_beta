import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoriteItams {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://milicart-b50ae.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> _loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          _loadedProducts.add(
            Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavorite: prodData['isFavorite'],
              imageUrl: prodData['imageUrl'],
            ),
          );
        },
      );
      _items = _loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://milicart-b50ae.firebaseio.com/products.json';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      //debug the code
      print(json.decode(response
          .body)); // this will show the id on the terminal, that was generated for the product from the server.

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.insert(0, newProduct); // insert to the begining of the product
      //_items.add(value);
      notifyListeners();
    } catch (error) {
      // this will throw to the interface where, user will be notified with a meaningful way
      throw (error);
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://milicart-b50ae.firebaseio.com/products/$id.json';
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          },
        ),
      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    final url = 'https://milicart-b50ae.firebaseio.com/products/$id.json';
    http.delete(url);
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
