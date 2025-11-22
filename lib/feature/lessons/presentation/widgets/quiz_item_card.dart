import 'package:educationofchildren/feature/lessons/domain/entities/quiz_entity.dart';
import 'package:educationofchildren/feature/lessons/presentation/bloc/storage/storage_bloc.dart';
import 'package:educationofchildren/feature/lessons/presentation/widgets/retake_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_size.dart';
import '../../data/repositories/answer_repository_implement.dart';
import '../pages/quiz_page.dart';

class QuizItemCard extends StatelessWidget {
  final QuizEntity quiz;
  final String quizID;
  final bool isDone;

  final int currentIndex;
  final int score;
  final List<bool> answers;

  const QuizItemCard({
    super.key,
    required this.quiz,
    required this.quizID,
    required this.isDone,
    required this.currentIndex,
    required this.score,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final storageBloc = context.read<StorageBloc>();
    return GestureDetector(
      onTap: () async {
        try {
          final newIndex = await Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => QuizPage(
                quizID: quizID,
                lessonTitle: quiz.title ?? '',
                questions: quiz.questions!,
                currentIndex: currentIndex,
                score: score,
                answers: answers,
                storageBloc: storageBloc,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    // ورود و خروج با Slide
                    const begin = Offset(0.0, 1.0); // صفحه از پایین وارد شود
                    const end = Offset.zero; // به موقعیت نهایی برسد
                    const curve = Curves.easeInOut;

                    final tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );

          if (newIndex != null) {}
        } catch (e) {
          print(e.toString());
        }
        if (isDone) return;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.cardcircular),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Icon circle --- //
                Container(
                  width: AppSize.iconsize,
                  height: AppSize.iconsize,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    quiz.icon ?? '',
                    style: TextStyle(fontSize: AppSize.fontLarge),
                  ),
                ),
                const SizedBox(width: 15),
                // --- Title + Age --- //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //وقتی که done برابر true شود currentindex همان تعداد عناصر است
                    if (isDone)
                      Row(
                        children: [
                          Text(
                            'Completed — Score :',
                            style: TextStyle(
                              fontFamily: "Pocas",
                              fontSize: AppSize.fontSmall,
                              color: Color(0xFF8EA84B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${score} / ${currentIndex}',
                            style: TextStyle(
                              fontSize: AppSize.fontSmall,
                              color: Color(0xFF8EA84B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    Text(
                      quiz.title ?? '',
                      style: TextStyle(
                        fontFamily: "Pocas",
                        fontSize: AppSize.fontMedium,
                        color: (isDone) ? Color(0xFF84A0BA) : Color(0xFF213547),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Age ${quiz.ageMin}–${quiz.ageMax}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.fontSmall,
                        color: (isDone) ? Color(0xFFABB8C6) : Color(0xFF738293),
                      ),
                    ),
                    if (currentIndex > 0 && (!isDone))
                      Text(
                        'You answered  ${currentIndex} questions.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8EA84B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (isDone)
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      bool confirmed = await showRetakeConfirmationDialog(context);
                      if (confirmed) {
                        // استفاده از Event جدید
                        storageBloc.add(RetakeAnswerByIDEvent(quizID));
                      }
                    } catch (e) {
                      debugPrint("Error in retake tap: $e");
                    }
                  },
                  child: Image(
                    image: AssetImage("assets/emoji/retake.png"),
                    height: AppSize.retakesizesmall,
                    width: AppSize.retakesizesmall,
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
