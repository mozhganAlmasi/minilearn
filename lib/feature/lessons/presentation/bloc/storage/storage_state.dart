part of 'storage_bloc.dart';

@immutable
sealed class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

final class StorageInitial extends StorageState {}

class AddAnswerState extends StorageState {
  final int score;
  final String quizID;
  AddAnswerState({required this.score, required this.quizID});

  @override
  List<Object> get props => [score, quizID];
}

class RemoveAnswerByIDState extends StorageState {
  final String id;
  RemoveAnswerByIDState(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveAllAnswerState extends StorageState {
  RemoveAllAnswerState();

  @override
  List<Object> get props => [];
}

class GetAllAnswerState extends StorageState {
  final List<AnswerModel> data;
  GetAllAnswerState(this.data);

  @override
  List<Object> get props => [data];
}

class AnswerErrorState extends StorageState {
  AnswerErrorState();

  @override
  List<Object> get props => [];
}
