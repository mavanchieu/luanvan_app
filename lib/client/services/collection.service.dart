import 'package:app_lv/client/models/collection_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ColelctionService {
  late List<CollectionModel> brandCollection;
  late List<CollectionModel> seasonalCollection;
  Future<List<CollectionModel>> getAllBrandCollection() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/collections/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        brandCollection = (json.decode(response.body) as List)
            .map((data) => CollectionModel.fromJson(data))
            .toList();
        print("Collection ${brandCollection.length}");
        return brandCollection;
      }
    } catch (e) {
      print(e);
      return brandCollection;
    }
    return brandCollection;
  }

  Future<List<CollectionModel>> getAllSeasonalCollection() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.56.1:3005/api/collections/seasonalCollection/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        seasonalCollection = (json.decode(response.body) as List)
            .map((data) => CollectionModel.fromJson(data))
            .toList();
        print("Collection ${seasonalCollection.length}");
        return seasonalCollection;
      }
    } catch (e) {
      print(e);
      return seasonalCollection;
    }
    return seasonalCollection;
  }
}
