import '../../../../core/error/failures.dart';
import '../entities/quiz_entity.dart';
import '../repositories/quiz_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetQuizzesUseCase {
  final QuizRepository repository;

  GetQuizzesUseCase(this.repository);

  Future<Either<Failure, List<QuizEntity>>> call() async {
    return await repository.getQuizzes();
  }
}
