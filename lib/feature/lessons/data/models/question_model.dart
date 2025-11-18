import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/question_entity.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends QuestionEntity {
  const QuestionModel({
    String? question,
    List<String>? choices,
    int? answerIndex,
  }) : super(
    question: question,
    choices: choices,
    answerIndex: answerIndex,
  );

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
