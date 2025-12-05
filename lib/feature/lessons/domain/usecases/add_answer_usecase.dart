import 'package:educationofchildren/core/usecase/UseCase.dart';
import 'package:educationofchildren/feature/lessons/data/models/answer_model.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/answer_repository_implement.dart';

class AddAnswerUsecase implements UseCase<bool , AnswerModel> {
  final AnswerRepositoryImplement repository;

  AddAnswerUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AnswerModel params) async {
    // type check
    if (params is! AnswerModel) {
      return Left(CacheFailure('Invalid parameter type'));
    }

    final AnswerModel answer = params;
    return repository.addAnswerResult(answer: answer);
  }
}
