import 'package:educationofchildren/feature/lessons/data/models/answer_model.dart';
import 'package:educationofchildren/feature/lessons/data/repositories/answer_repository_implement.dart';
import '../../../../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

class GetAnswerUseCase {
  final AnswerRepositoryImplement repository;

  GetAnswerUseCase(this.repository);

  Future<Either<Failure, List<AnswerModel>>> call() async {
    return await repository.getAnswers();
  }
}
