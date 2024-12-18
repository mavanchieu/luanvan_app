import 'package:app_lv/client/models/brand_model.dart';
import 'package:app_lv/client/services/brand.service.dart';
import 'package:flutter/material.dart';

class BrandManager with ChangeNotifier {
  List<BrandModel> _brands = [];
  List<BrandModel> get brands => _brands;

  Future<List<BrandModel>> fetchBrands() async {
    try {
      var brandService = BrandService();
      _brands = await brandService.getAll();
      notifyListeners();
      return _brands;
    } catch (e) {
      print(e);
    }
    return _brands;
  }
}
