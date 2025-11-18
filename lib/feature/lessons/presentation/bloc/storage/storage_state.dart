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

  DataStorageUpdatedState({required this.score});

  @override
  List<Object> get props => [score];
}
class DataStorageRetakeState extends StorageState {
  String id;
  DataStorageRetakeState(this.id);

  @override
  List<Object> get props => [];
}