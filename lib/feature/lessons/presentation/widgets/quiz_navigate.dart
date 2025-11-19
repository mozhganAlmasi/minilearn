import 'package:flutter/material.dart';
import '../../../../config/theme/colors.dart';

class QuizNavigation extends StatelessWidget {
  final bool isLast;
  final int currentIndex;
  final bool disableNextButton;
  final VoidCallback onNext;
  final VoidCallback onFinish;

  const QuizNavigation({
    super.key,
    required this.isLast,
    required this.currentIndex,
    required this.disableNextButton,
    required this.onNext,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFirst = currentIndex == 0;


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        /// ----- NEXT or FINISH BUTTON -----
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),

            // رنگ پس‌زمینه
            backgroundColor: mbtnprevnext,

            // گوشه‌های گرد
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),

            // سایه نرم و مدرن
            elevation: 6,
            shadowColor: Colors.black.withOpacity(0.25),

            // نوشته سفید و خوانا
            foregroundColor: Colors.white,

            // انیمیشن فشار دادن (نرم‌تر)
            animationDuration: const Duration(milliseconds: 180),
          ),

          onPressed: isLast ? onFinish : (disableNextButton ? null : onNext),
          child:Text(
              (isLast)?"Done": "Next", // متن دکمه
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),

      ],
    );
  }
}
