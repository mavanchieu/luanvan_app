import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_lv/client/models/discountCodes.model.dart';

class DiscountCodesService {
  late List<DiscountCodesModel> discountCodes;
  Future<List<DiscountCodesModel>> getDiscountCodes() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/discountCodes/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        discountCodes = (json.decode(response.body) as List)
            .map((data) => DiscountCodesModel.fromJson(data))
            .toList();
        print(discountCodes.length);
        return discountCodes;
      }
    } catch (e) {
      print(e);
      return discountCodes;
    }
    return discountCodes;
  }
}
