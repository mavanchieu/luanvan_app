import 'package:app_lv/client/models/brand_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandService {
  late List<BrandModel> brands;

  Future<List<BrandModel>> getAll() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/brands/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        brands = (json.decode(response.body) as List)
            .map((data) => BrandModel.fromJson(data))
            .toList();
        // print(brands.length);
        return brands;
      }
    } catch (e) {
      print(e);
      return brands;
    }
    return brands;
  }
}
