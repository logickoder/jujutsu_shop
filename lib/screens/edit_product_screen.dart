import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/user/product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _initialized = false;
  final _focusNodes = List.generate(3, (_) => FocusNode());
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _product =
      Product(id: '', title: '', description: '', imageUrl: '', price: 0.0);

  @override
  void initState() {
    _focusNodes.last.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      final product = ModalRoute.of(context)?.settings.arguments as Product?;
      if (product != null) {
        _product = product;
        _imageUrlController.text = _product.imageUrl;
      }
      _initialized = true;
    }
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_focusNodes.last.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_form.currentState?.validate() == true) {
      _form.currentState?.save();
      final products = Provider.of<Products>(context, listen: false);
      if (_product.id.isEmpty) {
        products.add(_product);
      } else {
        products.update(_product.id, _product);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _product.title,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focusNodes[0]);
                    },
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter a title.'
                          : null;
                    },
                    onSaved: (value) {
                      _product = _product.copy(title: value);
                    },
                  ),
                  TextFormField(
                    initialValue: _product.price.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _focusNodes[0],
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focusNodes[1]);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price.';
                      }
                      final number = double.tryParse(value);
                      if (number == null) {
                        return 'Please enter a valid number.';
                      }
                      if (number <= 0) {
                        return 'Please enter a number greater than zero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _product =
                          _product.copy(price: double.tryParse(value ?? ''));
                    },
                  ),
                  TextFormField(
                    initialValue: _product.description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    focusNode: _focusNodes[1],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      if (value.length < 10) {
                        return 'Description should be at least 10 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _product = _product.copy(description: value);
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? const Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Image URL',
                          ),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _focusNodes.last,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a url.';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _saveForm(),
                          onSaved: (value) {
                            _product = _product.copy(imageUrl: value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final node in _focusNodes) {
      node.dispose();
    }
    _imageUrlController.dispose();
  }
}
