import 'dart:convert';
import 'package:app_lv/client/models/search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SearchService {
  late List<SearchModel> searchModel;
  Future<List<SearchModel>> getByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/search/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        searchModel = (json.decode(response.body) as List)
            .map((data) => SearchModel.fromJson(data))
            .toList();
        // print(searchModel[0].searchName);
        return searchModel;
      }
    } catch (e) {
      print(e);
      return searchModel;
    }
    return searchModel;
  }

  Future<bool> create(String userId, String searchName) async {
    // print(userId);
    // print(searchName);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/search/'),
        body: jsonEncode({
          'userId': userId,
          'searchName': searchName,
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
        Uri.parse('http://192.168.56.1:3005/api/search/$id'),
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
    print(userId);
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.56.1:3005/api/search/deleteAll/$userId'),
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
