import 'package:app_lv/client/models/discountCodes.model.dart';
import 'package:app_lv/client/services/discountCodes.service.dart';
import 'package:flutter/material.dart';

class DiscountcodesManager with ChangeNotifier {
  List<DiscountCodesModel> _discountCodes = [];
  List<DiscountCodesModel> get discountCodes => _discountCodes;

  Future<List<DiscountCodesModel>> fetchDiscountCodes() async {
    try {
      var discountCodesService = DiscountCodesService();
      _discountCodes = await discountCodesService.getDiscountCodes();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _discountCodes;
  }
}
