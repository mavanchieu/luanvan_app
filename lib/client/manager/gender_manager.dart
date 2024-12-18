import 'package:app_lv/client/models/gender_model.dart';
import 'package:app_lv/client/services/gender.service.dart';
import 'package:flutter/material.dart';

class GenderManager with ChangeNotifier {
  List<GenderModel> _genders = [];
  List<GenderModel> get genders => _genders;

  Future<List<GenderModel>> fetchGenders() async {
    try {
      var genderService = GenderService();
      _genders = await genderService.getAll();
      notifyListeners();
      return _genders;
    } catch (e) {
      print(e);
    }
    return _genders;
  }

  String genderId() {
    fetchGenders();
    var id = _genders[0].id;
    return id;
  }
}
