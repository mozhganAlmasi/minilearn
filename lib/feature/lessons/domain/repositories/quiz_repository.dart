import 'package:educationofchildren/feature/lessons/domain/entities/quiz_entity.dart';

abstract class QuizRepository {
  Future<List<QuizEntity>> getQuizzes();
}
