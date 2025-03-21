import 'dart:convert';

import 'package:api/model/product_data.dart';
import 'package:api/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductUpdateScreen extends StatefulWidget {
  const ProductUpdateScreen({super.key, required this.product});

  final ProductData product;

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productNameTEController.text = widget.product.productName!;
    _productCodeTEController.text = widget.product.productCode.toString();
    _priceTEController.text = widget.product.unitPrice.toString();
    _imageTEController.text = widget.product.img!;
    _quantityTEController.text = widget.product.qty.toString();
    _totalPriceTEController.text = widget.product.totalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        title: const Text('Update Product'),
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
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _productNameTEController,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    labelText: 'Product Name',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _productCodeTEController,
                  decoration: InputDecoration(
                    hintText: 'Product Code',
                    labelText: 'Product Code',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _priceTEController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _imageTEController,
                  decoration: InputDecoration(
                    hintText: 'Image',
                    labelText: 'Image',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _quantityTEController,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Value';
                    }
                    return null;
                  },
                  controller: _totalPriceTEController,
                  decoration: InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'Total Price',
                  ),
                ),
                const SizedBox(height: 24),
                _inProcess
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: _onTabUpdateProduct,
                        child: Text(
                          'Update',
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

  void _onTabUpdateProduct() {
    if (_formKey.currentState!.validate()) {
      _onTabUpdate();
    }
  }


  Future<void> _onTabUpdate() async {
    _inProcess = true;
    setState(() {});
    Uri uri = Uri.parse(
        Urls.updateProduct(widget.product.sId!));

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
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Updated Successfully'),
          backgroundColor: Colors.green,
          elevation: 5,
        ),
      );
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
      print('Response: ${response.body}');
    }
    _inProcess = false;
    setState(() {});
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _productCodeTEController.dispose();
    _priceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();
  }
}
