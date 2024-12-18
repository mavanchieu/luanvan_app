import 'dart:io';

import 'package:app_lv/client/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/retry.dart';

class UserService {
  late UserModel user;
  late List<UserModel> allUser;
  Future<UserModel> getUserById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/users/$id'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Convert the Map into a UserModel instance
        user = UserModel.fromJson(jsonResponse);
        return user;
      }
    } catch (e) {
      print(e);
      return user;
    }
    return user;
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/users/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        allUser = (json.decode(response.body) as List)
            .map((data) => UserModel.fromJson(data))
            .toList();

        return allUser;
      }
    } catch (e) {
      print(e);
      return allUser;
    }
    return allUser;
  }

  Future<bool> editPassword(String userId, String password) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/users/updateUser/$userId'),
        body: jsonEncode({
          'password': password,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> editFullname(String userId, String fullname) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/users/updateUser/$userId'),
        body: jsonEncode({
          'fullname': fullname,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> editGender(String userId, String gender) async {
    print(gender);
    try {
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/users/updateUser/$userId'),
        body: jsonEncode({
          'gender': gender,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> editEmail(String userId, String email) async {
    try {
      print(userId);
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/users/updateUser/$userId'),
        body: jsonEncode({
          'email': email,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> editPhone(String userId, String phone) async {
    try {
      print(userId);
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/users/updateUser/$userId'),
        body: jsonEncode({
          'phone': phone,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> editDate(String userId, String birth) async {
    print(birth);
    try {
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/users/updateUser/$userId'),
        body: jsonEncode({
          'birth': birth,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateImage(String userId, File image) async {
    try {
      // final response = await http.put(
      //   Uri.parse('http://192.168.56.1:3005/api/users/updateImage/$userId'),
      //   body: jsonEncode({
      //     'image': image.path,
      //   }),
      //   headers: {
      //     "Content-Type": "multipart/form-data",
      //   },
      // );
      // print(userId);
      // print(image.path);
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://192.168.56.1:3005/api/users/updateImage/'),
      );
      request.fields['userId'] = userId;
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      var response = await request.send();
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
