import 'package:educationofchildren/feature/lessons/data/repositories/answer_repository_implement.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';

class RemoveAllAnswerUsecase {
  final AnswerRepositoryImplement repository;

  RemoveAllAnswerUsecase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.removeAllAnswer();
  }
}
