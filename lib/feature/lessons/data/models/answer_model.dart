import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/answer_entity.dart';
import 'answer_result_model.dart';

part 'answer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AnswerModel extends AnswerEntity<AnswerResultModel> {
  AnswerModel({
    required super.quizID,
    required super.isDone,
    required super.userAnswer,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}
