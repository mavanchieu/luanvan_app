import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupService with ChangeNotifier {
  Future<bool> signup(String name, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.56.1:3005/api/users/'),
      body: jsonEncode({
        'username': name,
        'password': password,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.isNotEmpty) {
        // print(responseData);
      }

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
