import 'package:app_lv/client/models/evaluation_model.dart';
import 'package:app_lv/client/services/evaluation.service.dart';

import 'package:flutter/material.dart';

class EvaluationManager with ChangeNotifier {
  List<EvaluationModel> _evals = [];
  List<EvaluationModel> get evals => _evals;

  List<EvaluationModel> _evalsByUserId = [];
  List<EvaluationModel> get evalsByUserId => _evalsByUserId;

  Future<List<EvaluationModel>> fetchEvalutions(String userId) async {
    try {
      var evalService = EvaluationService();
      _evals = await evalService.getEvaluations();
      _evalsByUserId = _evals.where((eval) => eval.userId == userId).toList();
      notifyListeners();
      return _evals;
    } catch (e) {
      print(e);
    }
    return _evals;
  }
}
