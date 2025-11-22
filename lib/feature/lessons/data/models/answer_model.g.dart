// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
  quizID: json['quizID'] as String,
  isDone: json['isDone'] as bool,
  userAnswer: (json['userAnswer'] as List<dynamic>)
      .map((e) => AnswerResultModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'quizID': instance.quizID,
      'isDone': instance.isDone,
      'userAnswer': instance.userAnswer.map((e) => e.toJson()).toList(),
    };
