import 'answer_result_entity.dart';

class AnswerEntity<T extends AnswerResultEntity> {
  final String quizID;
  final bool isDone;
  final List<T> userAnswer;

  AnswerEntity({
    required this.quizID,
    required this.isDone,
    required this.userAnswer,
  });
}
