import 'package:MiliCart/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ManageSingleProductScreen extends StatefulWidget {
  static const routeName = '/manage-single-product';
  @override
  _ManageSingleProductScreenState createState() =>
      _ManageSingleProductScreenState();
}

class _ManageSingleProductScreenState extends State<ManageSingleProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _managedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _managedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);

        _initValues = {
          'title': _managedProduct.title,
          'description': _managedProduct.description,
          'price': _managedProduct.price.toString(),
          //'imageUrl': _managedProduct.imageUrl,
        };

        _imageUrlController.text = _managedProduct.imageUrl;
      }
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    // check for all the validators
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_managedProduct.id != null) {
      //edit product
      Provider.of<Products>(context, listen: false)
          .updateProduct(_managedProduct.id, _managedProduct);
      setState(() {
        _isLoading = false;
      });
      // This will go back to the previous page.
      Navigator.of(context).pop();
    } else {
      //add product
      Provider.of<Products>(context, listen: false)
          .addProduct(_managedProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        // This will go back to the previous page.
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Single Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Titile'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Titile for the product !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _managedProduct = Product(
                          title: value,
                          id: _managedProduct.id,
                          isFavorite: _managedProduct.isFavorite,
                          description: _managedProduct.description,
                          price: _managedProduct.price,
                          imageUrl: _managedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price for the Product!';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number for the Product!';
                        }
                        if (double.tryParse(value) <= 0) {
                          return 'Please enter a number greate than zero for the product!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _managedProduct = Product(
                          title: _managedProduct.title,
                          id: _managedProduct.id,
                          isFavorite: _managedProduct.isFavorite,
                          description: _managedProduct.description,
                          price: double.parse(value),
                          imageUrl: _managedProduct.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _managedProduct = Product(
                          title: _managedProduct.title,
                          id: _managedProduct.id,
                          isFavorite: _managedProduct.isFavorite,
                          description: value,
                          price: _managedProduct.price,
                          imageUrl: _managedProduct.imageUrl,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description for the Product!';
                        }
                        if (value.length < 10) {
                          return 'Description should be at least 10 charactors long or more!';
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: Theme.of(context).accentColor,
                          )),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Please Enter an URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _managedProduct = Product(
                                title: _managedProduct.title,
                                id: _managedProduct.id,
                                isFavorite: _managedProduct.isFavorite,
                                description: _managedProduct.description,
                                price: _managedProduct.price,
                                imageUrl: value,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
