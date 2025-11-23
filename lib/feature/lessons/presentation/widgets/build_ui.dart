import 'package:educationofchildren/feature/lessons/data/models/answer_model.dart';
import 'package:educationofchildren/feature/lessons/data/models/quiz_model.dart';
import 'package:educationofchildren/feature/lessons/presentation/bloc/storage/storage_bloc.dart';
import 'package:educationofchildren/feature/lessons/presentation/widgets/quiz_item_card.dart';
import 'package:educationofchildren/feature/lessons/presentation/widgets/retake_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../data/models/quiz_extracted_info.dart';
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
  List<AnswerModel> answerData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    context.read<StorageBloc>().add(GetAllAnswerStorageEvent());
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
          if (state is GetAllAnswerState) {
            answerData = state.data;
            context.read<QuizBloc>().add(LoadQuizzesEvent());
          } else if (state is RemoveAllAnswerState) {
            await loadData(); // دیتا دوباره لود شود
          } else if (state is RemoveAnswerByIDState) {
            await loadData();
          }else if(state is AddAnswerState){
            await loadData();
          }
            else if (state is AnswerErrorState) {
            debugPrint("StorageBloc error");
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
                      return _buildList(state, answerData);
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
                      onTap: () async {
                        try {
                          bool confirmed = await showRetakeConfirmationDialog(context);
                          if (confirmed) {
                            retakeAll();
                          }
                        } catch (e) {
                          debugPrint("Error showing dialog: $e");
                        }
                      }

                  ),
                ),
              )

            ],
          ),

      ),
    );
  }

  Widget _buildList(QuizLoaded state, List<AnswerModel> lstAnswer) {
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
        final currentAnswerReleas = getAnswerForQuiz(quiz.id , lstAnswer , state.quizzes.length);
        return QuizItemCard(
          quizID: quiz.id ?? '',
          quiz: quiz,
          isDone:currentAnswerReleas.isDone,
          currentIndex: currentAnswerReleas.currentIndex,
          score: currentAnswerReleas.score,
        );
      },
    );
  }



  void retakeAll() async {
    try {
      context.read<StorageBloc>().add(RetakeAllAnswerStorageEvent());
    } catch (e) {
      debugPrint("Error in retakeAll: $e");
    }
  }

  QuizExtractedInfo getAnswerForQuiz( quizID ,List<AnswerModel> answers , int itemCount){
    bool isDone =false;
    int currentIndex =0;
    int score =0;
    for (var answer in answers) {
      if(answer.quizID == quizID){
        isDone = answer.isDone;
        currentIndex = answer.userAnswer.length;
        if(itemCount == currentIndex) isDone = true;
        for (var result in answer.userAnswer) {
            if(result.result == true) score++;
        }
      }
    }
    return QuizExtractedInfo(isDone:isDone , score:score , currentIndex:currentIndex);

  }

}
