import 'dart:convert';

import 'package:api/model/product.dart';
import 'package:api/model/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 42),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _productNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                    labelText: 'Product Name',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _productCodeTEController,
                  decoration: const InputDecoration(
                    hintText: 'Product Code',
                    labelText: 'Product Code',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value==null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _priceTEController,
                  decoration: const InputDecoration(
                    hintText: 'Price',
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value==null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _imageTEController,
                  decoration: const InputDecoration(
                    hintText: 'Image',
                    labelText: 'Image',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value==null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _quantityTEController,
                  decoration: const InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _totalPriceTEController,
                  decoration: const InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'Total Price',
                  ),
                ),
                const SizedBox(height: 24),
                _inProgress
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: _onTabAddButton,
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabAddButton() {
    if (_formKey.currentState!.validate()) {
      onTabAddProduct();
    }
  }



  Future<void> onTabAddProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse(Urls.createProduct);

    Map<String, dynamic> requestBody = {
      "ProductName": _productNameTEController.text,
      "ProductCode": int.parse(_productCodeTEController.text),
      "Img": _imageTEController.text,
      "Qty": int.parse(_quantityTEController.text),
      "UnitPrice": int.parse(_priceTEController.text),
      "TotalPrice": int.parse(_totalPriceTEController.text),
    };
    Response response = await post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _onTabClearTextFlied();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add Product Successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          elevation: 5,
        ),
      );
    }
    _inProgress = false;
    setState(() {});
  }

  void _onTabClearTextFlied() {
    _productNameTEController.clear();
    _productCodeTEController.clear();
    _priceTEController.clear();
    _imageTEController.clear();
    _quantityTEController.clear();
    _totalPriceTEController.clear();
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _productCodeTEController.dispose();
    _priceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
