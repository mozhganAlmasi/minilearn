import 'package:flutter/material.dart';
import '../../../../core/utils/app_size.dart';
import '../../data/datasources/local/quiz_local_data_source.dart';
import '../../data/repositories/answer_repository_implement.dart';
import '../../data/repositories/quiz_repository_impl.dart';
import '../../domain/usecases/add_answer_usecase.dart';
import '../../domain/usecases/get_answers_usecase.dart';
import '../../domain/usecases/get_quizzes_usecase.dart';
import '../bloc/quiz/quiz_bloc.dart';
import '../bloc/quiz/quiz_event.dart';
import '../bloc/storage/storage_bloc.dart';
import '../widgets/build_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectQuiz extends StatefulWidget {
  const SelectQuiz({super.key});

  @override
  State<SelectQuiz> createState() => _SelectQuizState();
}

class _SelectQuizState extends State<SelectQuiz> {

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(
          create: (_) {
            final dataSource = QuizLocalDataSourceImpl();
            final repo = QuizRepositoryImpl(dataSource);
            final useCase = GetQuizzesUseCase(repo);
            final bloc = QuizBloc(useCase);
            bloc.add(LoadQuizzesEvent());
            return bloc;
          },
        ),
        BlocProvider<StorageBloc>(
          create: (_) => StorageBloc(
            getAnswerUseCase: GetAnswerUseCase(AnswerRepositoryImplement()),
            addAnswerUsecase: AddAnswerUsecase(AnswerRepositoryImplement()),
            repository: AnswerRepositoryImplement(),
          ),
        )

      ],
      child: const BulidUi(),
    );

  }
}
