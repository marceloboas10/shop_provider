// ignore_for_file: prefer_void_to_null

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_shop_provider/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _iamageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _iamageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final product = ModalRoute.of(context)!.settings.arguments as Product?;

      if (product != null || product != null) {
        _formData['id'] = product.id ?? Random().nextDouble().toString();
        _formData['title'] = product.title ?? '';
        _formData['description'] = product.description ?? '';
        _formData['price'] = product.price ?? '';
        _formData['imageUrl'] = product.imageUrl ?? '';
        _imageUrlController.text = _formData['imageUrl'] as String;
      }
    }
  }

  void _updateImage() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _iamageUrlFocusNode.removeListener(_updateImage);
    _iamageUrlFocusNode.dispose();
  }

  Future<void> saveForm() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    final newProduct = Product(
        id: _formData['id'] != null ? _formData['id'] as String : null,
        title: _formData['title'] as String,
        description: _formData['description'].toString(),
        price: _formData['price'] as double,
        imageUrl: _formData['imageUrl'] as String);

    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    setState(() {
      isLoading = true;
    });

    try {
      if (_formData['id'] == null) {
        await productProvider.addProduct(newProduct);
      } else {
        await productProvider.updateProduct(newProduct);
      }

      Navigator.of(context).pop();
    } catch (e) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro ao Salvar'),
          content: const Text('Ocorreu um erro ao salvar o produto!'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Produto'),
        actions: [
          IconButton(onPressed: saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['title'] != null
                          ? _formData['title'] as String
                          : '',
                      decoration: const InputDecoration(labelText: 'Título'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) => _formData['title'] = value!,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe um nome!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString() ?? "",
                      decoration: const InputDecoration(labelText: 'Preço'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) =>
                          _formData['price'] = double.parse(value!),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe um preço!';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Informe um preço válido!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description'] != null
                          ? _formData['description'] as String
                          : '',
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) => _formData['description'] = value!,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe uma descrição!';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _iamageUrlFocusNode,
                            controller: _imageUrlController,
                            onSaved: (value) => _formData['imageUrl'] = value!,
                            onFieldSubmitted: (_) {
                              saveForm();
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 6, left: 6),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Infomre a URL')
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
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
