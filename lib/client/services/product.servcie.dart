import 'package:app_lv/client/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  late List<ProductModel> products;
  late List<ProductModel> allProducts;
  Future<List<ProductModel>> getAll() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/products/findAllByProductId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        products = (json.decode(response.body) as List)
            .map((data) => ProductModel.fromJson(data))
            .toList();
        // print("Số lượng sản phẩm ${products.length}");
        return products;
      }
    } catch (e) {
      print(e);
      return products;
    }
    return products;
  }

  // tất cả sản phẩm kể cả hidden true hoặc false
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/products/findAllProducts'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        allProducts = (json.decode(response.body) as List)
            .map((data) => ProductModel.fromJson(data))
            .toList();
        // print("Số lượng sản phẩm ${allProducts.length}");
        return allProducts;
      }
    } catch (e) {
      print(e);
      return products;
    }
    return products;
  }

  Future<bool> updateQuantity(
      String colorItemId, String sizeId, int quantity) async {
    final response = await http.put(
      Uri.parse(
          'http://192.168.56.1:3005/api/colorItems/updateQuantity/$colorItemId/$sizeId/$quantity'),
      // body: jsonEncode({
      //   'username': name,
      //   'password': password,
      // }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateInscreaseQuantity(
      String colorItemId, String sizeId, int quantity) async {
    final response = await http.put(
      Uri.parse(
          'http://192.168.56.1:3005/api/colorItems/updateInscreaseQuantity/$colorItemId/$sizeId/$quantity'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print(colorItemId);
    print(sizeId);
    print(quantity);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteOneOrder(String orderId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.56.1:3005/api/orders/$orderId'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
