import 'package:educationofchildren/core/usecase/UseCase.dart';
import 'package:educationofchildren/feature/lessons/data/repositories/answer_repository_implement.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';

class RemoveAllAnswerUsecase implements UseCase<bool, void> {
  final AnswerRepositoryImplement repository;

  RemoveAllAnswerUsecase(this.repository);

  Future<Either<Failure, bool>> call(void _) async {
    return await repository.removeAllAnswer();
  }
}
