import 'package:equatable/equatable.dart';

import '../../../domain/entities/quiz_entity.dart';



abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuizEntity> quizzes;
  const QuizLoaded(this.quizzes);

  @override
  List<Object?> get props => [quizzes];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
