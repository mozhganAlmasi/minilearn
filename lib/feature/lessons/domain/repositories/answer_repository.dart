import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/answer_entity.dart';
import '../entities/answer_result_entity.dart';



abstract class AnswerRepository {
  Future<Either<Failure, List<AnswerEntity<AnswerResultEntity>>>> getAnswers();
}
