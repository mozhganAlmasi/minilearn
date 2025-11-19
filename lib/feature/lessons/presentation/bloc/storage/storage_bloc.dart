import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  StorageBloc() : super(StorageInitial()) {
    on<UpdateAnswerStorageEvent>((event, emit) {
      emit(StorageInitial());
      emit(DataStorageUpdatedState(score: event.score , quizID:event.quizID));
    });
    on<RetakeStorageEvent>((event, emit) {
      emit(StorageInitial());
      emit(DataStorageRetakeState(event.id));
    });
  }
}

