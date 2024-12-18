import 'dart:convert';
import 'package:app_lv/client/models/userDiscountCode.dart';
import 'package:http/http.dart' as http;
import 'package:app_lv/client/models/discountCodes.model.dart';

class UserDiscountCodeService {
  late List<UserDiscountCodeModel> userDiscountCodes;
  late List<UserDiscountCodeModel> userDiscountCodeByUserId;
  Future<List<UserDiscountCodeModel>> getUserDiscountCode() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/usersDiscountCode/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        userDiscountCodes = (json.decode(response.body) as List)
            .map((data) => UserDiscountCodeModel.fromJson(data))
            .toList();
        // print(userdiscountCodes.length);
        return userDiscountCodes;
      }
    } catch (e) {
      print(e);
      return userDiscountCodes;
    }
    return userDiscountCodes;
  }

  Future<List<UserDiscountCodeModel>> getUserDiscountCodeByUserId(
      String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:3005/api/usersDiscountCode/findDiscountByUserId/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        userDiscountCodeByUserId = (json.decode(response.body) as List)
            .map((data) => UserDiscountCodeModel.fromJson(data))
            .toList();
        print(userDiscountCodeByUserId.length);
        return userDiscountCodeByUserId;
      }
    } catch (e) {
      print(e);
      return userDiscountCodeByUserId;
    }
    return userDiscountCodeByUserId;
  }

  Future<bool> update(String id) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3005/api/usersDiscountCode/$id'),
        body: jsonEncode({}),
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

  Future<bool> createUserDiscountCode(
      String userId, String discountCodeId) async {
    // print(userId);
    // print(searchName);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/usersDiscountCode/'),
        body: jsonEncode({
          'userId': userId,
          'discountCodeId': discountCodeId,
          'used': false,
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
}
