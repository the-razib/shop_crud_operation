class ProductData {
  String? sId;
  String? productName;
  int? productCode;
  String? img;
  int? qty;
  int? unitPrice;
  int? totalPrice;

  ProductData(
      {this.sId,
        this.productName,
        this.productCode,
        this.img,
        this.qty,
        this.unitPrice,
        this.totalPrice});

  ProductData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    img = json['Img'];
    qty = json['Qty'];
    unitPrice = json['UnitPrice'];
    totalPrice = json['TotalPrice'];
  }
}
