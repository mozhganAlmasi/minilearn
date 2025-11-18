import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/quiz_entity.dart';
import 'question_model.dart';

part 'quiz_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizModel extends QuizEntity<QuestionModel> {
  const QuizModel({
    String? id,
    String? title,
    int? ageMin,
    int? ageMax,
    String? icon,
    List<QuestionModel>? questions,
  }) : super(
    id: id,
    title: title,
    ageMin: ageMin,
    ageMax: ageMax,
    icon: icon,
    questions: questions,
  );

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizModelToJson(this);
}
