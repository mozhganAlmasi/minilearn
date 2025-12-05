import 'package:educationofchildren/core/usecase/UseCase.dart';
import 'package:educationofchildren/feature/lessons/data/models/answer_model.dart';
import 'package:educationofchildren/feature/lessons/data/repositories/answer_repository_implement.dart';
import '../../../../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

class GetAnswerUseCase implements UseCase<List<AnswerModel> , void>{
  final AnswerRepositoryImplement repository;

  GetAnswerUseCase(this.repository);

  Future<Either<Failure, List<AnswerModel>>> call(void _) async {
    return await repository.getAnswers();
  }
}
