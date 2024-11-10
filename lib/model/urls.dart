class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2008/api/v1';

  static const String readProduct = '$_baseUrl/ReadProduct';
  static const String createProduct = '$_baseUrl/CreateProduct';
  static String deleteProduct(String id) => '$_baseUrl/DeleteProduct/$id';
  static String updateProduct(String id) => '$_baseUrl/UpdateProduct/$id';
}
