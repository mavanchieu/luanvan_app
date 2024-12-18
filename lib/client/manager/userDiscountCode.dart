import 'package:app_lv/client/models/discountCodes.model.dart';
import 'package:app_lv/client/models/userDiscountCode.dart';
import 'package:app_lv/client/services/userDiscountCode.service.dart';
import 'package:flutter/material.dart';

class UserDiscountCodeManager with ChangeNotifier {
  List<UserDiscountCodeModel> _userDiscountCodes = [];
  List<UserDiscountCodeModel> get userDiscountCodes => _userDiscountCodes;

  List<UserDiscountCodeModel> _userDiscountCodesByUserId = [];
  List<UserDiscountCodeModel> get userDiscountCodesByUserId =>
      _userDiscountCodesByUserId;

  Future<List<UserDiscountCodeModel>> fetchUserDiscountCode() async {
    try {
      var userDiscountCodesService = UserDiscountCodeService();
      _userDiscountCodes = await userDiscountCodesService.getUserDiscountCode();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _userDiscountCodes;
  }

  Future<List<UserDiscountCodeModel>> fetchUserDiscountCodeByUserId(
      String userId) async {
    try {
      var userDiscountCodesService = UserDiscountCodeService();
      _userDiscountCodesByUserId =
          await userDiscountCodesService.getUserDiscountCodeByUserId(userId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _userDiscountCodesByUserId;
  }

  Future<bool> update(String id) async {
    try {
      var userDiscountCodesService = UserDiscountCodeService();
      bool result = await userDiscountCodesService.update(id);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> createUserDiscountCode(
      String userId, String discountCodeId) async {
    try {
      var userDiscountCodesService = UserDiscountCodeService();
      bool result = await userDiscountCodesService.createUserDiscountCode(
          userId, discountCodeId);
      await fetchUserDiscountCodeByUserId(userId);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
