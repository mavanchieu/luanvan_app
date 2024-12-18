import 'dart:convert';
import 'package:app_lv/client/models/typeDetail_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TypeDetailService {
  late List<TypeDetailModel> typeDetails;
  Future<List<TypeDetailModel>> getAllTypeDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/typeDetails/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        typeDetails = (json.decode(response.body) as List)
            .map((data) => TypeDetailModel.fromJson(data))
            .toList();
        // print(typeDetails;[0].searchName);
        return typeDetails;
      }
    } catch (e) {
      print(e);
      return typeDetails;
    }
    return typeDetails;
  }
}
