part of 'storage_bloc.dart';

@immutable
sealed class StorageEvent extends Equatable {
  const StorageEvent();

  @override
  List<Object> get props => [];
}

class AddAnswerStorageEvent extends StorageEvent {
  final AnswerModel answer;
  AddAnswerStorageEvent(this.answer);

  @override
  List<Object> get props => [answer.quizID]; // یا کل answer اگر Equatable است
}

class RetakeAnswerByIDEvent extends StorageEvent {
  final String id;
  RetakeAnswerByIDEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RetakeAllAnswerStorageEvent extends StorageEvent {
  RetakeAllAnswerStorageEvent();

  @override
  List<Object> get props => [];
}

class GetAllAnswerStorageEvent extends StorageEvent {
  GetAllAnswerStorageEvent();

  @override
  List<Object> get props => [];
}
class MarkAnswerDoneEvent extends StorageEvent {
  final String quizID;
  const MarkAnswerDoneEvent(this.quizID);

  @override
  List<Object> get props => [quizID];
}

