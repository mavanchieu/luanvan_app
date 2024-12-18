import 'package:app_lv/client/models/typeDetail_model.dart';
import 'package:app_lv/client/services/typeDetail.service.dart';
import 'package:flutter/material.dart';

class TypeDetailManager with ChangeNotifier {
  List<TypeDetailModel> _typeDetails = [];
  List<TypeDetailModel> get typeDetails => _typeDetails;

  List<TypeDetailModel> _typeDetailsByGenderId = [];
  List<TypeDetailModel> get typeDetailsByGenderId => _typeDetailsByGenderId;

  Future<List<TypeDetailModel>> fetchAllTypeDetails() async {
    try {
      var typeDetailService = TypeDetailService();
      _typeDetails = await typeDetailService.getAllTypeDetails();

      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _typeDetails;
  }

  Future<List<TypeDetailModel>> fetchAllTypeDetailsByGenderId(
      String genderId1) async {
    try {
      await fetchAllTypeDetails();
      _typeDetailsByGenderId = _typeDetails
          .where((element) => element.genderId == genderId1)
          .toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _typeDetailsByGenderId;
  }
}
