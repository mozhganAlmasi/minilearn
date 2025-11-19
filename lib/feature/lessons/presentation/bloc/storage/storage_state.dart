part of 'storage_bloc.dart';

@immutable
sealed class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

final class StorageInitial extends StorageState {}

class DataStorageUpdatedState extends StorageState {
  final int score;
  final String quizID;
  DataStorageUpdatedState({required this.score , required this.quizID});

  @override
  List<Object> get props => [score, quizID];
}
class DataStorageRetakeState extends StorageState {
  String id;
  DataStorageRetakeState(this.id);

  @override
  List<Object> get props => [];
}