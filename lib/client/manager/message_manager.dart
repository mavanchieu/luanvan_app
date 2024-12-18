import 'package:app_lv/client/models/message.dart';
import 'package:app_lv/client/models/search_model.dart';
import 'package:app_lv/client/services/message.service.dart';
import 'package:app_lv/client/services/search.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessageManager with ChangeNotifier {
  List<ChatModel> _chatModel = [];

  List<ChatModel> get chatModel => _chatModel;

  Future<List<ChatModel>> fetchMesssage(String userId) async {
    try {
      var messageService = MessageService();
      _chatModel = await messageService.getAll();
      _chatModel =
          _chatModel.where((element) => element.userId == userId).toList();
      print(_chatModel.length);
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _chatModel;
  }

  Future<bool> create(String userId, String content) async {
    try {
      var messageService = MessageService();
      bool result = await messageService.create(userId, content);
      if (result) {
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  // Future<bool> create(String userId, String searchName) async {
  //   try {
  //     var searchService = SearchService();

  //     // Kiểm tra xem từ khóa có tồn tại chưa
  //     bool nameExists = _searchModel.any((searchModel) =>
  //         searchModel.searchName.toLowerCase() ==
  //             searchName.toLowerCase().trim() &&
  //         searchModel.userId == userId);
  //     if (nameExists) {
  //       return false;
  //     } else {
  //       bool result = await searchService.create(userId, searchName);
  //       if (result) {
  //         fetchByUserId(userId);
  //         notifyListeners();
  //         return true;
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  //   return false;
  // }
}
