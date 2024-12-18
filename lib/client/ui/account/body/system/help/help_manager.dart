import 'package:app_lv/client/models/help_model.dart';
import 'package:app_lv/client/services/Help.service.dart';
import 'package:flutter/material.dart';

class HelpManager with ChangeNotifier {
  List<HelpModel> _helpModel = [];
  List<HelpModel> get helpModel => _helpModel;

  Future<List<HelpModel>> fetchByUserId(String userId) async {
    try {
      var helpService = HelpService();
      _helpModel = await helpService.getByUserId(userId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _helpModel;
  }

  Future<bool> create(String userId, String fullname, String phone,
      String email, String question) async {
    try {
      // print(userId);
      // print(fullname);
      // print(phone);
      // print(email);
      // print(question);
      var helpService = HelpService();
      bool result =
          await helpService.create(userId, fullname, phone, email, question);
      if (result) {
        fetchByUserId(userId);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }
}
