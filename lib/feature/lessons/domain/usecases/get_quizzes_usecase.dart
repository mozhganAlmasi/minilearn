import 'package:educationofchildren/core/usecase/UseCase.dart';

import '../../../../core/error/failures.dart';
import '../entities/quiz_entity.dart';
import '../repositories/quiz_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetQuizzesUseCase implements UseCase<List<QuizEntity> , void> {
  final QuizRepository repository;

  GetQuizzesUseCase(this.repository);

  Future<Either<Failure, List<QuizEntity>>> call(void _) async {
    return await repository.getQuizzes();
  }
}
