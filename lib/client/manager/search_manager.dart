import 'package:app_lv/client/models/search_model.dart';
import 'package:app_lv/client/services/search.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchManager with ChangeNotifier {
  List<SearchModel> _searchModel = [];

  List<SearchModel> get searchModel => _searchModel;

  Future<List<SearchModel>> fetchByUserId(String userId) async {
    try {
      var searchService = SearchService();
      _searchModel = await searchService.getByUserId(userId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _searchModel;
  }

  Future<bool> create(String userId, String searchName) async {
    try {
      var searchService = SearchService();

      // Kiểm tra xem từ khóa có tồn tại chưa
      bool nameExists = _searchModel.any((searchModel) =>
          searchModel.searchName.toLowerCase() ==
              searchName.toLowerCase().trim() &&
          searchModel.userId == userId);
      if (nameExists) {
        return false;
      } else {
        bool result = await searchService.create(userId, searchName);
        if (result) {
          fetchByUserId(userId);
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> deleteOne(String id) async {
    try {
      var searchService = SearchService();
      bool result = await searchService.deleteOne(id);
      if (result) {
        var _search = _searchModel.firstWhere((element) => element.id == id);
        _searchModel.remove(_search);
        // print(_searchModel.length);
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
      var searchService = SearchService();
      bool result = await searchService.deleteAll(userId);
      if (result) {
        _searchModel = [];
        //  print(_searchModel.length);
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
