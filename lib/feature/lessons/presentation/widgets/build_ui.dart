import 'package:educationofchildren/feature/lessons/presentation/bloc/storage/storage_bloc.dart';
import 'package:educationofchildren/feature/lessons/presentation/widgets/quiz_item_card.dart';
import 'package:educationofchildren/feature/lessons/presentation/widgets/retake_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../data/models/quiz_extracted_info.dart';
import '../../data/repositories/answer_storage.dart';
import '../bloc/quiz/quiz_bloc.dart';
import '../bloc/quiz/quiz_event.dart';
import '../bloc/quiz/quiz_state.dart';
import 'age_selector.dart';

class BulidUi extends StatefulWidget {
  const BulidUi({super.key});

  @override
  State<BulidUi> createState() => _BulidUiState();
}

class _BulidUiState extends State<BulidUi> {
  int? _selectedAge;
  List<dynamic> quizData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await AnswerStorage.getAll();
    setState(() {
      quizData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBlueLight,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppSize.height * 0.1),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFFD6E8),
          title: Text(
            'Choose a lesson',
            style: TextStyle(
              fontFamily: "Autumn",
              fontSize: AppSize.fontLarge,
              color: Color(0xFF213547),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: BlocListener<StorageBloc, StorageState>(
        listener: (context, state) async {
          if (state is DataStorageUpdatedState) {
            await loadData();
            setState(() {
              context.read<QuizBloc>().add(LoadQuizzesEvent());
            });
          }else if(state is DataStorageRetakeState){
            await AnswerStorage.remove(state.id);
            await loadData();
            setState(() {

            });
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            // ✔ ویجت جدا
            AgeSelector(
              selectedAge: _selectedAge,
              onSelected: (age) {
                setState(() => _selectedAge = age);
                context.read<QuizBloc>().add(FilterByAgeEvent(age));
              },
            ),

            const SizedBox(height: 10),

            Expanded(

              child: BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) {
                  if (state is QuizLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is QuizLoaded) {
                    return _buildList(state, quizData);
                  } else if (state is QuizError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Retake All",
                          style: TextStyle(
                            fontSize: AppSize.fontMedium,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/emoji/retake.png',
                        width: AppSize.retakesizelarg,
                        height: AppSize.retakesizelarg,
                      ),
                    ],
                  ),
                  onTap: ()  async {
                    bool confirmed = await showRetakeConfirmationDialog(context);
                    if (confirmed) {
                      retakeAll();}
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildList(QuizLoaded state, List<dynamic> lstAnswer) {
    if (state.quizzes.isEmpty) {
      return const Center(
        child: Text(
          'No Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mError,
            fontSize: 50,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: state.quizzes.length,
      itemBuilder: (context, index) {
        final quiz = state.quizzes[index];
        final quizInfo = _extractQuizInfo(quiz.id ?? '', lstAnswer);

        return QuizItemCard(
          quizID: quiz.id ?? '',
          quiz: quiz,
          isDone: quizInfo.isDone,
          currentIndex: quizInfo.answerCount,
          score: quizInfo.score,
          answers: quizInfo.answers,
        );
      },
    );
  }

  QuizExtractedInfo _extractQuizInfo(String quizId, List<dynamic> lstAnswer) {
    final idx = lstAnswer.indexWhere(
      (item) => item != null && item["id"]?.toString() == quizId,
    );

    if (idx == -1) {
      return QuizExtractedInfo(
        isDone: false,
        answerCount: 0,
        score: 0,
        answers: [],
      );
    }

    final data = lstAnswer[idx];
    final isDone = (data["done"] == 'true');
    final results = data["result"] as List<dynamic>? ?? [];

    int score = results.where((ans) => ans['iscurrect'] == "true").length;
    List<bool> answers = results
        .map<bool>((ans) => ans['iscurrect'] == "true")
        .toList();
    return QuizExtractedInfo(
      isDone: isDone,
      answerCount: results.length,
      score: score,
      answers: answers,
    );
  }

  void retakeAll() {

    setState(() async{
      await AnswerStorage.removeAll();
      await loadData();
    });
  }
}
