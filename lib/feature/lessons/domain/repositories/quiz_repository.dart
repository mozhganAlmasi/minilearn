import 'package:educationofchildren/feature/lessons/domain/entities/quiz_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/question_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<QuizEntity<QuestionEntity>>>> getQuizzes();
}
