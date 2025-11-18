import 'package:educationofchildren/config/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_size.dart';

class AgeSelector extends StatelessWidget {
  final int? selectedAge;
  final Function(int) onSelected;

  const AgeSelector({
    super.key,
    required this.selectedAge,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final ages = [3, 4, 5, 6 , 7 ,8];

    return Wrap(
      alignment: WrapAlignment.center,
      children: ages.map<Widget>((age) {
        final isSelected = selectedAge == age;
        return GestureDetector(
          onTap: () => onSelected(age),
          child: Container(

            margin: EdgeInsets.symmetric(horizontal: AppSize.paddingSmall),
            padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium, vertical: AppSize.paddingSmall),
            decoration: BoxDecoration(
              color: isSelected ? Colors.pink[200] : mPinkLight,
              borderRadius: BorderRadius.circular(AppSize.agecircular),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Text(
               "$age",
              style: TextStyle(
                fontSize: AppSize.fontMedium,
                fontFamily: "Autumn",
                color: Color(0xFF213547),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
