import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuizzesEvent extends QuizEvent {}

class FilterByAgeEvent extends QuizEvent {
  final int age;

  const FilterByAgeEvent(this.age);

  @override
  List<Object?> get props => [age];
}
