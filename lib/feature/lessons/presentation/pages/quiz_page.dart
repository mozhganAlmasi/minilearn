import 'package:educationofchildren/core/utils/app_size.dart';
import 'package:educationofchildren/feature/lessons/domain/entities/question_entity.dart';
import 'package:educationofchildren/feature/lessons/presentation/pages/select_quiz.dart';
import 'package:flutter/material.dart';
import '../../../../config/theme/colors.dart';
import '../../data/repositories/answer_storage.dart';
import '../bloc/storage/storage_bloc.dart';
import '../widgets/quiz_navigate.dart';

class QuizPage extends StatefulWidget {
  final String quizID;
  final String lessonTitle;
  final List<QuestionEntity> questions;
  final int currentIndex;
  final StorageBloc storageBloc;
  final int score;
  final List<bool> answers;

  const QuizPage({
    super.key,
    required this.quizID,
    required this.lessonTitle,
    required this.questions,
    required this.currentIndex,
    required this.storageBloc,
    required this.score,
    required this.answers,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int selectedIndex = -1;
  late int currentIndex = widget.currentIndex;
  late int starCount = widget.score;
  late int totalQuestions = widget.questions.length;
  late List<int> selectedAnswerIndex;
  late List<bool> answers = widget.answers;
  late bool isCorrectPerQuestion;
  bool isDone = false;
  bool disabelAnswerButton = false;
  bool disableNextButton = true;
  late QuestionEntity question;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isCorrectPerQuestion = false;
    selectedAnswerIndex = List.generate(totalQuestions, (_) => -1);
    loadAnswerStar();
  }

  @override
  Widget build(BuildContext context) {
    question = widget.questions[currentIndex];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mPink,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.height * 0.03),

                /// Progress
                Text(
                  "Question ${currentIndex + 1} of ${widget.questions.length}",
                  style: TextStyle(
                    fontFamily: 'Designer',
                    fontSize: AppSize.fontMedium,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: AppSize.height * 0.05),
                Container(
                  color: mPinkLight,
                  child: Column(
                    children: [
                      SizedBox(height: AppSize.height * 0.03),

                      /// Question text
                      Text(
                        "${question.question}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: 'Designer',
                          fontSize: AppSize.fontSmall,
                          color: mTextPrimary,
                        ),
                      ),

                      SizedBox(height: AppSize.height * 0.04),

                      /// Choices
                      ...List.generate(question.choices?.length ?? 0, (index) {
                        final choice = question.choices![index];

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: AppSize.height * 0.02,
                            left: AppSize.height * 0.02,
                            right: AppSize.height * 0.02,
                          ),
                          child: GestureDetector(
                            onTap: () => (disabelAnswerButton)
                                ? null
                                : onAnswerTap(question, index),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,

                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: AppSize.height * 0.02,
                                horizontal: AppSize.width * 0.04,
                              ),

                              decoration: BoxDecoration(
                                color: _getButtonColor(index),
                                borderRadius: _getRadius(index),

                                border: Border.all(
                                  color: _getBorderColor(index),
                                  width: 2,
                                ),
                              ),

                              child: Text(
                                choice,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppSize.width * 0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                QuizNavigation(
                  isLast: (currentIndex + 1 == totalQuestions),
                  currentIndex: currentIndex,
                  disableNextButton: disableNextButton,
                  onNext: () => onNextQuestion(),
                  // onPrev: () => onPreviousQuestion(),
                  onFinish: () => onFinishQuiz(),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Wrap(
                    children: List.generate(
                      starCount,
                      (i) => Image(image: AssetImage("assets/img/star.png")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onAnswerTap(QuestionEntity q, int answerIndex) async {
    try {
      bool checkCurrect = (q.answerIndex == answerIndex);
      if (checkCurrect) starCount++;
      await AnswerStorage.addResult(
        id: widget.quizID,
        isdone: isDone.toString(),
        quizeindex: currentIndex.toString(),
        iscurrect: checkCurrect.toString(),
      );
      setState(() {
        disabelAnswerButton = true;
        disableNextButton = false;
        selectedAnswerIndex[currentIndex] = answerIndex;
        isCorrectPerQuestion = checkCurrect;
      });

      widget.storageBloc.add(UpdateAnswerStorageEvent(currentIndex ,widget.quizID));
      if (currentIndex + 1 == totalQuestions)
        AnswerStorage.changeDone(widget.quizID);
    } catch (e) {
      print("onAnswerTap: $e");
    }
  }

  Color _getButtonColor(int optionIndex) {
    if (selectedAnswerIndex[currentIndex] != optionIndex) {
      return mBlueLight;
    }

    return isCorrectPerQuestion ? Colors.green.shade300 : Colors.red.shade300;
  }

  Color _getBorderColor(int optionIndex) {
    if (selectedAnswerIndex[currentIndex] != optionIndex) {
      return mBlue;
    }

    return isCorrectPerQuestion ? Colors.green : Colors.red;
  }

  BorderRadius _getRadius(int optionIndex) {
    if (selectedAnswerIndex[currentIndex] != optionIndex) {
      return BorderRadius.circular(14);
    }

    if (isCorrectPerQuestion) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(70),
        bottomRight: Radius.circular(70),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(70),
        topRight: Radius.circular(70),
      );
    }
  }

  void onNextQuestion() {
    setState(() {
      if (currentIndex + 1 < totalQuestions) {
        currentIndex++;
      }
      disableNextButton = true;
      disabelAnswerButton = false;
    });
  }

  void onPreviousQuestion() {
    setState(() {
      if (currentIndex > 0) currentIndex--;
      if(selectedAnswerIndex[currentIndex] != -1) disabelAnswerButton = false;
    });
  }

  void onFinishQuiz() {
    setState(() {
      AnswerStorage.changeDone(widget.quizID);
    });
    Navigator.of(context).pop();
  }
  
  void loadAnswerStar() {
    for (var q in widget.questions) {}
  }
}
