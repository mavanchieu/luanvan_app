import 'package:app_lv/client/models/viewedProduct_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewedProductService {
  late List<ViewedProductModel> viewedProducts;
  Future<List<ViewedProductModel>> getByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:3005/api/viewedProducts/findByUserId/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        viewedProducts = (json.decode(response.body) as List)
            .map((data) => ViewedProductModel.fromJson(data))
            .toList();
        // print(viewedProducts.length);
        return viewedProducts;
      }
    } catch (e) {
      print(e);
      return viewedProducts;
    }
    return viewedProducts;
  }

  Future<bool> create(String userId, String productId) async {
    // print(userId);
    // print(productId);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/viewedProducts/'),
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  // Future<bool> deleteOne(String id) async {
  //   try {
  //     final response = await http.delete(
  //       Uri.parse('http://192.168.56.1:3005/api/favorites/$id'),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  //   return false;
  // }

  Future<bool> deleteAll(String userId) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'http://192.168.56.1:3005/api/viewedProducts/deleteAll/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }
}
