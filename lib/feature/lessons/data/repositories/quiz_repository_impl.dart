import '../../domain/entities/quiz_entity.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/local/quiz_local_data_source.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl(this.localDataSource);

  @override
  Future<List<QuizEntity>> getQuizzes() async {
    final models = await localDataSource.loadQuizzes();
    return models;
  }
}

