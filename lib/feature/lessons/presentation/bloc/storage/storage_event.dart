part of 'storage_bloc.dart';

@immutable
sealed class StorageEvent extends Equatable{

  const StorageEvent();
  @override
  List<Object> get props => [];
}
class UpdateAnswerStorageEvent extends StorageEvent {
  int score;
  String quizID;
  UpdateAnswerStorageEvent(this.score , this.quizID);
  @override
  List<Object> get props => [score ,quizID];
}
class RetakeStorageEvent extends StorageEvent {
  String id;
   RetakeStorageEvent(this.id);
  @override
  List<Object> get props => [id];
}
