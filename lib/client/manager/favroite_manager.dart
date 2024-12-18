import 'package:app_lv/client/models/favorite_model.dart';
import 'package:app_lv/client/models/product_model.dart';
import 'package:app_lv/client/services/favorite.service.dart';
import 'package:app_lv/client/services/product.servcie.dart';
import 'package:flutter/material.dart';

class FavoriteManager with ChangeNotifier {
  List<FavoriteModel> _favorites = [];
  List<FavoriteModel> get favorites => _favorites;

  List<ProductModel> _products = [];
  Future<List<FavoriteModel>> fetchFavorites(userId) async {
    try {
      var favoriteService = FavoriteService();
      var productService = ProductService();
      _products = await productService.getAll();
      final fav = await favoriteService.getByUserId(userId);
      _favorites = fav.where((fav) {
        return _products.any((pro) => pro.id! == fav.productId);
      }).toList();
      // print(_favorites.length);

      notifyListeners();
      return _favorites;
    } catch (e) {
      print(e);
    }
    return _favorites;
  }

  Future<bool> create(String userId, String productId) async {
    try {
      var favoriteService = FavoriteService();
      bool a = await favoriteService.create(userId, productId);
      if (a) {
        fetchFavorites(userId);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> deleteOne(userId, String pdId) async {
    try {
      var favoriteService = FavoriteService();
      var favorite =
          _favorites.firstWhere((element) => element.productId == pdId);
      bool result = await favoriteService.deleteOne(favorite.id);
      if (result) {
        favorites.remove(favorite);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> deleteAll(String userId) async {
    try {
      var favoriteService = FavoriteService();
      bool result = await favoriteService.deleteAll(userId);
      if (result) {
        favorites.clear();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  bool isNotEmpty(String userId, String pdId) {
    fetchFavorites(userId);
    bool productId =
        _favorites.any((fav) => fav.productId == pdId && fav.userId == userId);
    if (productId) {
      return true;
    }
    return false;
  }
}
