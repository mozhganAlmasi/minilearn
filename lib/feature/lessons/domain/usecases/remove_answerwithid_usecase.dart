import 'package:educationofchildren/core/usecase/UseCase.dart';
import 'package:educationofchildren/feature/lessons/data/repositories/answer_repository_implement.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';

class RemoveAnswerWithIdUsecase implements UseCase<bool , String>{
  final AnswerRepositoryImplement repository;

  RemoveAnswerWithIdUsecase(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    return await repository.removeAnswerWithID(id);
  }
}
