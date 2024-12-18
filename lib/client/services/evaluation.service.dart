import 'dart:io';

import 'package:app_lv/client/models/evaluation_model.dart';
import 'package:app_lv/client/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EvaluationService {
  late List<EvaluationModel> evals;
  Future<List<EvaluationModel>> getEvaluations() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.56.1:3005/api/evaluations/'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        evals = (json.decode(response.body) as List)
            .map((data) => EvaluationModel.fromJson(data))
            .toList();
        return evals;
      }
    } catch (e) {
      print(e);
      return evals;
    }
    return evals;
  }

  Future<bool> addToRate(
      String userId,
      String productOrderId,
      String productId,
      bool incognito,
      String content,
      double rate,
      String sizeName,
      String colorItemName,
      String fullname,
      String date,
      List<File> images) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.56.1:3005/api/evaluations/'),
      );
      request.fields['userId'] = userId;
      request.fields['productOrderId'] = productOrderId;
      request.fields['productId'] = productId;
      request.fields['incognito'] = incognito.toString();
      request.fields['content'] = content;
      request.fields['rate'] = rate.toString();
      request.fields['sizeName'] = sizeName;
      request.fields['colorItemName'] = colorItemName;
      request.fields['fullname'] = fullname;
      request.fields['date'] = date;
      for (var image in images) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image.path));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> handleLike(String userId, String evalId) async {
    // print(userId);
    // print(searchName);
    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.56.1:3005/api/evaluations/updateLike/$userId/$evalId'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      print(e);
    }
  }
}
