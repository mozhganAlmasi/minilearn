// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  ageMin: (json['ageMin'] as num?)?.toInt(),
  ageMax: (json['ageMax'] as num?)?.toInt(),
  icon: json['icon'] as String?,
  questions: (json['questions'] as List<dynamic>?)
      ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'ageMin': instance.ageMin,
  'ageMax': instance.ageMax,
  'icon': instance.icon,
  'questions': instance.questions?.map((e) => e.toJson()).toList(),
};
