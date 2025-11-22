// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerResultModel _$AnswerResultModelFromJson(Map<String, dynamic> json) =>
    AnswerResultModel(
      index: (json['index'] as num).toInt(),
      result: json['result'] as bool,
      userAnswerIndex: (json['userAnswerIndex'] as num).toInt(),
    );

Map<String, dynamic> _$AnswerResultModelToJson(AnswerResultModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'result': instance.result,
      'userAnswerIndex': instance.userAnswerIndex,
    };
