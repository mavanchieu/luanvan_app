import 'package:app_lv/client/models/message.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MessageService {
  late List<ChatModel> chatModel;
  Future<List<ChatModel>> getAll() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/message'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        chatModel = (json.decode(response.body) as List)
            .map((data) => ChatModel.fromJson(data))
            .toList();
        return chatModel;
      }
    } catch (e) {
      print(e);
      return chatModel;
    }
    return chatModel;
  }

  Future<bool> create(String userId, String content) async {
    // print(userId);
    // print(searchName);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:3005/api/message/'),
        body: jsonEncode({
          'userId': userId,
          'content': content,
          'status': '0',
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
