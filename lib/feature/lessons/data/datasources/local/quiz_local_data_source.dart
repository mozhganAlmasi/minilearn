import 'dart:convert';
import 'package:flutter/services.dart';

import '../../models/quiz_model.dart';

abstract class QuizLocalDataSource {
  Future<List<QuizModel>> loadQuizzes();
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  @override
  Future<List<QuizModel>> loadQuizzes() async {
    final jsonString = await rootBundle.loadString('assets/lesson.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => QuizModel.fromJson(item)).toList();
  }
}
