import 'package:app_lv/client/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class CartService {
  late List<CartModel> carts;
  Future<List<CartModel>> getByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/carts/findByUserId/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        carts = (json.decode(response.body) as List)
            .map((data) => CartModel.fromJson(data))
            .toList();
        print(carts.length);
        return carts;
      }
    } catch (e) {
      print(e);
      return carts;
    }
    return carts;
  }

  Future<bool> create(
    String userId,
    String productId,
    String colorItemId,
    String sizeId,
    int quanitty,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/carts/'),
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
          'colorItemId': colorItemId,
          'sizeId': sizeId,
          'quantity': quanitty,
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

  Future<bool> updateCart(String id, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/carts/updateCart/$id'),
        body: jsonEncode({
          'quantity': quantity,
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

  Future<bool> deleteOne(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.56.1:3005/api/carts/$id'),
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

  Future<bool> deleteAll(String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.56.1:3005/api/carts/deleteAll/$userId'),
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
