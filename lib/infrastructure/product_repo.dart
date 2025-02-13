import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jothilabproject/domain/product_model.dart';

class ProductRepository {
  static const baseUrl = "https://dummyjson.com/";
  static const productsEndpoint = "products";

  Future<ProductsModel?> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$productsEndpoint"));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        return ProductsModel.fromJson(json);
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    return null;
  }
}
