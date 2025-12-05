import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../data/models/answer_model.dart';
import '../../../data/repositories/answer_repository_implement.dart';
import '../../../domain/usecases/add_answer_usecase.dart';
import '../../../domain/usecases/get_answers_usecase.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final GetAnswerUseCase getAnswerUseCase;
  final AddAnswerUsecase addAnswerUsecase;
  final AnswerRepositoryImplement repository;

  StorageBloc({
    required this.getAnswerUseCase,
    required this.addAnswerUsecase,
    required this.repository,
  }) : super(StorageInitial()) {
    // دریافت همه پاسخ‌ها
    on<GetAllAnswerStorageEvent>((event, emit) async {
      emit(StorageInitial());
      final result = await getAnswerUseCase(null);
      result.fold(
            (failure) => emit(AnswerErrorState()),
            (answers) => emit(GetAllAnswerState(answers)),
      );
    });

    on<AddAnswerStorageEvent>((event, emit) async {
      emit(StorageInitial());

      final result = await addAnswerUsecase.call( event.answer);

      result.fold(
            (failure) => emit(AnswerErrorState()),
            (_) => emit(AddAnswerState(
          score: event.answer.userAnswer.length, // یا منطق واقعی score
          quizID: event.answer.quizID,
        )),
      );
    });


    // حذف همه پاسخ‌ها
    on<RetakeAllAnswerStorageEvent>((event, emit) async {
      emit(StorageInitial());
      final result = await repository.removeAllAnswer();
      result.fold(
            (failure) => emit(AnswerErrorState()),
            (_) => emit(RemoveAllAnswerState()),
      );
    });

    // حذف پاسخ با quizID خاص
    on<RetakeAnswerByIDEvent>((event, emit) async {
      emit(StorageInitial());
      final result = await repository.removeAnswerWithID(event.id);
      result.fold(
            (failure) => emit(AnswerErrorState()),
            (_) => emit(RemoveAnswerByIDState(event.id)),
      );
    });

    on<MarkAnswerDoneEvent>((event, emit) async {
      final result = await repository.markAnswerDone(event.quizID); // متد جدید در repository
      result.fold(
            (failure) => emit(AnswerErrorState()),
            (_) => emit(AddAnswerState(score: 0, quizID: event.quizID)), // یا state دلخواه
      );
    });

  }
}
