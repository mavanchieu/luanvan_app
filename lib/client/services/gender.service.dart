import 'package:app_lv/client/models/gender_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderService {
  late List<GenderModel> genders;

  Future<List<GenderModel>> getAll() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/genders/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        genders = (json.decode(response.body) as List)
            .map((data) => GenderModel.fromJson(data))
            .toList();
        // print(genders.length);
        return genders;
      }
    } catch (e) {
      print(e);
      return genders;
    }
    return genders;
  }
}
