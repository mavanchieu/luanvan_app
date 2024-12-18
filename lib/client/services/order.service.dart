import 'package:app_lv/client/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderService {
  late List<OrderModel> orders;
  Future<List<OrderModel>> getByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/orders/findByUserId/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        orders = (json.decode(response.body) as List)
            .map((data) => OrderModel.fromJson(data))
            .toList();
        print(orders.length);
        return orders;
      }
    } catch (e) {
      print(e);
      return orders;
    }
    return orders;
  }

  Future<bool> create(
    String fullname,
    String address,
    String phone,
    String email,
    String userId,
    List<Map<String, dynamic>> products,
    String totalPrice,
    String date,
    String paymentMethod,
    int discount,
    String userDiscountCodeId,
    String code,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/orders/'),
        body: jsonEncode({
          'fullname': fullname,
          'address': address,
          'phone': phone,
          'email': email,
          'userId': userId,
          'status': "0",
          'products': products,
          'totalPrice': totalPrice,
          'date': date,
          'paymentMethod': paymentMethod,
          'code': code,
          'userDiscountCodeId': userDiscountCodeId,
          'discount': discount.toString(),
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print("Lỗi + ${e}");
      return false;
    }
    return false;
  }
}
