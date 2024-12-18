import 'package:app_lv/client/models/viewedProduct_model.dart';
import 'package:app_lv/client/models/viewedProduct_model.dart';
import 'package:app_lv/client/services/viewedProduct.service.dart';
import 'package:flutter/material.dart';

class ViewedProductManager with ChangeNotifier {
  List<ViewedProductModel> _viewedProducts = [];
  List<ViewedProductModel> get viewedProducts => _viewedProducts;

  Future<List<ViewedProductModel>> fetchViewedProducts(userId) async {
    try {
      var viewedProductService = ViewedProductService();
      _viewedProducts = await viewedProductService.getByUserId(userId);
      notifyListeners();
      return _viewedProducts;
    } catch (e) {
      print(e);
    }
    return _viewedProducts;
  }

  Future<bool> deleteAll(String userId) async {
    try {
      var viewedProductService = ViewedProductService();
      bool result = await viewedProductService.deleteAll(userId);
      if (result) {
        _viewedProducts.clear();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> create(String userId, String productId) async {
    await fetchViewedProducts(userId);
    try {
      bool viewProduct = _viewedProducts.any((element) =>
          element.productId == productId && element.userId == userId);
      if (viewProduct != true) {
        var viewedProductService = ViewedProductService();
        bool a = await viewedProductService.create(userId, productId);
        if (a) {
          fetchViewedProducts(userId);
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
