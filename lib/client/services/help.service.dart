import 'dart:convert';

import 'package:app_lv/client/models/help_model.dart';
import 'package:http/http.dart' as http;

class HelpService {
  List<HelpModel> helpModel = [];
  Future<List<HelpModel>> getByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/helps/findByUserId/$userId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        helpModel = (json.decode(response.body) as List)
            .map((data) => HelpModel.fromJson(data))
            .toList();
        //print(helpModel.length);
        return helpModel;
      }
    } catch (e) {
      print(e);
      return helpModel;
    }
    return helpModel;
  }

  Future<bool> create(String userId, String fullname, String phone,
      String email, String question) async {
    // print(userId);
    // print(fullname);
    // print(phone);
    // print(email);
    // print(question);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/helps/'),
        body: jsonEncode({
          'userId': userId,
          'fullname': fullname,
          'phone': phone,
          'email': email,
          'question': question,
          'reply': {
            'userIdReply': "",
            'answer': "",
          }
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
