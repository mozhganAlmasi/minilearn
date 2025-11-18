import 'package:educationofchildren/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: '',
  scaffoldBackgroundColor: mBg,
  primaryColor: mPink,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: mBlue),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: AppSize.fontMedium, color: mTextPrimary),
    bodyMedium: TextStyle(fontSize: AppSize.fontSmall, color: mTextPrimary),
  ),
);
