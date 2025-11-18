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
    try {
      final quizzes = await getQuizzesUseCase();
      _allQuizzes = quizzes;
      emit(QuizLoaded(quizzes));
    } catch (e) {
      emit(QuizError('Error On Load Data $e'));
    }
  }

  void _onFilterByAge(FilterByAgeEvent event, Emitter<QuizState> emit) {
    final filtered = _allQuizzes.where((q) {
      if (q.ageMin == null || q.ageMax == null) return false;
      return q.ageMin! <= event.age && q.ageMax! >= event.age;
    }).toList();

    emit(QuizLoaded(filtered));
  }
}
