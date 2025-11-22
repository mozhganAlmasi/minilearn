import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/answer_result_entity.dart';

part 'answer_result_model.g.dart';

@JsonSerializable()
class AnswerResultModel extends AnswerResultEntity {
  AnswerResultModel({
    required super.index,
    required super.result,
    required super.userAnswerIndex,
  });

  factory AnswerResultModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerResultModelToJson(this);
}
