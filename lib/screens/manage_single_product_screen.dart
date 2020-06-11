import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();

    //debug
    print(_managedProduct.title);
    print(_managedProduct.price);
    print(_managedProduct.description);
    print(_managedProduct.imageUrl);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Titile'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _managedProduct = Product(
                    title: value,
                    id: null,
                    description: _managedProduct.description,
                    price: _managedProduct.price,
                    imageUrl: _managedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _managedProduct = Product(
                    title: _managedProduct.title,
                    id: null,
                    description: _managedProduct.description,
                    price: double.parse(value),
                    imageUrl: _managedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _managedProduct = Product(
                    title: _managedProduct.title,
                    id: null,
                    description: value,
                    price: _managedProduct.price,
                    imageUrl: _managedProduct.imageUrl,
                  );
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
                          id: null,
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
