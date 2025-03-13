import "package:api/model/product_data.dart";

class ProductReadModel {
  String? status;
  List<ProductData>? productList;

  ProductReadModel({this.status, this.productList});

  ProductReadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      productList = <ProductData>[];
      json['data'].forEach((v) {
        productList!.add(new ProductData.fromJson(v));
      });
    }
  }
}

