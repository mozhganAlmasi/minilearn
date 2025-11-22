import '../../../../core/error/failures.dart';
import '../../domain/entities/question_entity.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/local/quiz_local_data_source.dart';
import 'package:fpdart/fpdart.dart';

import '../models/quiz_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl(this.localDataSource);


  @override
  Future<Either<Failure, List<QuizEntity<QuestionEntity>>>> getQuizzes() async {
    try {
      final List<QuizModel> quizModels = await localDataSource.loadQuizzes();
      // تبدیل هر مدل به انتیتی
      final quizzes = quizModels.map((qm) => QuizEntity<QuestionEntity>(
        id: qm.id,
        title: qm.title,
        ageMin: qm.ageMin,
        ageMax: qm.ageMax,
        icon: qm.icon,
        questions: qm.questions?.map((q) => QuestionEntity(
          question: q.question,
          choices: q.choices,
          answerIndex: q.answerIndex,
        )).toList(),
      )).toList();

      return Right(quizzes);
    } catch (e) {
      return Left(CacheFailure('Failed to load quizzes'));
    }
  }


}

