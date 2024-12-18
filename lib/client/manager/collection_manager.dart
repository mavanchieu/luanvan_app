import 'package:app_lv/client/models/collection_model.dart';
import 'package:app_lv/client/services/collection.service.dart';
import 'package:flutter/material.dart';

class CollectionManager with ChangeNotifier {
  List<CollectionModel> _brandCollection = [];
  List<CollectionModel> get brandCollection => _brandCollection;

  List<CollectionModel> _seasonalCollection = [];
  List<CollectionModel> get seasonalCollection => _seasonalCollection;

  late CollectionModel _seasonalCollectionById;
  CollectionModel get seasonalCollectionById => _seasonalCollectionById;

  Future<List<CollectionModel>> fetchAllBrandCollection() async {
    try {
      var collectionService = ColelctionService();
      _brandCollection = await collectionService.getAllBrandCollection();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _brandCollection;
  }

  Future<List<CollectionModel>> fetchAllSeasonalCollection() async {
    try {
      var collectionService = ColelctionService();
      _seasonalCollection = await collectionService.getAllSeasonalCollection();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _seasonalCollection;
  }

  Future<CollectionModel> fetchOneSeasonalCollection(String id) async {
    try {
      print(id);
      _seasonalCollectionById =
          _seasonalCollection.firstWhere((element) => element.id! == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return _seasonalCollectionById;
  }
}
