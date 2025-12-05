import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/quiz_entity.dart';
import '../../../domain/usecases/get_quizzes_usecase.dart';
import 'quiz_event.dart';
import '../quiz/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuizzesUseCase getQuizzesUseCase;
  List<QuizEntity> _allQuizzes = [];

  QuizBloc(this.getQuizzesUseCase) : super(QuizInitial()) {
    on<LoadQuizzesEvent>(_onLoadQuizzes);
    on<FilterByAgeEvent>(_onFilterByAge);
  }

  Future<void> _onLoadQuizzes(
      LoadQuizzesEvent event, Emitter<QuizState> emit) async {
    emit(QuizLoading());

    final result = await getQuizzesUseCase(null);

    result.fold(
          (failure) => emit(QuizError('Error On Load Data: ${failure.message}')),
          (quizzes) {
        _allQuizzes = quizzes;
        emit(QuizInitial());
        emit(QuizLoaded(quizzes));
      },
    );
  }


  void _onFilterByAge(FilterByAgeEvent event, Emitter<QuizState> emit) {
    final filtered = _allQuizzes.where((q) {
      if (q.ageMin == null || q.ageMax == null) return false;
      return q.ageMin! <= event.age && q.ageMax! >= event.age;
    }).toList();
    emit(QuizInitial());
    emit(QuizLoaded(filtered));
  }
}
