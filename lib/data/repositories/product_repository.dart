import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchPosts() async {
    const String baseUrl = 'https://api.escuelajs.co/api/v1';

    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      final List<dynamic> jsonData = json.decode(response.body);
      final List<Product> blogs =
          jsonData.map((json) => Product.fromJson(json)).toList();
      return blogs;
    } catch (ex) {
      throw ex;
    }
  }
}
