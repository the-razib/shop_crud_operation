import 'dart:convert';

import 'package:api/model/product.dart';
import 'package:api/model/urls.dart';
import 'package:api/screens/add_new_product_screen.dart';
import 'package:api/screens/product_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: () {
              getProductList();
            },
            icon: const Icon(
              Icons.refresh_sharp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return _productInformation(productList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 4,
                );
              },
              itemCount: productList.length),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTabFABButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _productInformation(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(product.productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Code: ${product.productCode}'),
            Text('Price: \$${product.unitePrice}'),
            Text('Quantity: ${product.quantity}'),
            Text('Total Price: \$${product.totalPrice}'),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // edit icon
                IconButton(
                  onPressed: () {
                    _onTabEditButton(product);
                  },
                  icon: const Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 4),
                      Text('Edit'),
                    ],
                  ),
                ),
                _inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return alertDialogForProductDelet(
                                    context, product);
                              });
                        },
                        icon: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            SizedBox(width: 4),
                            Text('Delete'),
                          ],
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget alertDialogForProductDelet(BuildContext context, Product product) {
    return AlertDialog(
      title: const Text(
        'Are you sure? want to delete',
        style: TextStyle(fontSize: 14),
      ),
      backgroundColor: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancle')),
        TextButton(
            onPressed: () {
              _onTabDelete(product.productID);
              Navigator.pop(context);
            },
            child: const Text('Ok')),
      ],
    );
  }

  void _onTabFABButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewProductScreen(),
      ),
    );
  }

  void _onTabEditButton(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductUpdateScreen(
          product: product,
        ),
      ),
    );
  }

  /// Product Delete
  Future<void> _onTabDelete(String productID) async {
    _inProgress = true;
    setState(() {});
    Uri uri =
        Uri.parse(Urls.deleteProduct(productID));
    Response response = await get(uri);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully Delete'),
          backgroundColor: Colors.green,
        ),
      );
      getProductList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Try Again later'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }
    _inProgress = false;
    setState(() {});
  }

  /// Receive product
  Future<void> getProductList() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse(Urls.readProduct);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);
    print(response.runtimeType);

    if (response.statusCode == 200) {
      productList.clear();
      Map<String, dynamic> jsonCode = jsonDecode(response.body);
      for (var item in jsonCode['data']) {
        Product product = Product(
          productID: item['_id'],
          productName: item['ProductName'] ?? 'demo',
          productCode: item['ProductCode'] ?? 0000,
          productImage: item['img'] ?? 'Invalid image',
          quantity: item['Qty'] ?? 00,
          unitePrice: item['UnitPrice'] ?? 00,
          totalPrice: item['TotalPrice'] ?? 00,
        );
        productList.add(product);
      }
    }

    _inProgress = false;
    setState(() {});
  }
}
