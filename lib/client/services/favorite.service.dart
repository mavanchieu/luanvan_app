import 'package:app_lv/client/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteService {
  late List<FavoriteModel> genders;
  Future<List<FavoriteModel>> getByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:3005/api/favorites/findByUserId/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        genders = (json.decode(response.body) as List)
            .map((data) => FavoriteModel.fromJson(data))
            .toList();
        // print(genders.length);
        return genders;
      }
    } catch (e) {
      print(e);
      return genders;
    }
    return genders;
  }

  Future<bool> create(String userId, String productId) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/favorites/'),
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
          'date': DateTime.now().toString().split('.')[0],
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
        Uri.parse('http://192.168.56.1:3005/api/favorites/$id'),
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
        Uri.parse('http://192.168.56.1:3005/api/favorites/deleteAll/$userId'),
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
