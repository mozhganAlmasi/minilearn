part of 'storage_bloc.dart';

@immutable
sealed class StorageEvent extends Equatable{

  const StorageEvent();
  @override
  List<Object> get props => [];
}
class UpdateAnswerStorageEvent extends StorageEvent {
  int score;
  UpdateAnswerStorageEvent(this.score);
  @override
  List<Object> get props => [score];
}
class RetakeStorageEvent extends StorageEvent {
  String id;
   RetakeStorageEvent(this.id);
  @override
  List<Object> get props => [id];
}
