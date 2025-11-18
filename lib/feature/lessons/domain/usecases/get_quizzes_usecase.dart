import '../entities/quiz_entity.dart';
import '../repositories/quiz_repository.dart';

class GetQuizzesUseCase {
  final QuizRepository repository;

  GetQuizzesUseCase(this.repository);

  Future<List<QuizEntity>> call() async {
    return await repository.getQuizzes();
  }
}
