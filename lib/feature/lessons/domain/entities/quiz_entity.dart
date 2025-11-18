import 'package:educationofchildren/feature/lessons/data/models/question_model.dart';

import 'question_entity.dart';

class QuizEntity<T extends QuestionEntity> {
  final String? id ;
  final String? title;
  final int? ageMin;
  final int? ageMax;
  final String? icon;
  final List<T>? questions;

  const QuizEntity({
    this.id,
    this.title,
    this.ageMin,
    this.ageMax,
    this.icon,
    this.questions,
  });
}
