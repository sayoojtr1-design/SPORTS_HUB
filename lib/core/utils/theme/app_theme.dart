

import 'package:e_store/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
   brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightScaffold,

    appBarTheme: const AppBarTheme(

      backgroundColor: AppColors.white,
      foregroundColor: AppColors.greenAccent,
      elevation: 0,

    ),
    cardColor: AppColors.lightCard,
    colorScheme: const ColorScheme.light(
      primary: AppColors.white,
      secondary: AppColors.greenAccent,
      surface: AppColors.white
    ),


    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),

      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.white,
      ),

    ),

  );


  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkScaffold,

    appBarTheme: const AppBarTheme(

      backgroundColor: AppColors.white,
      foregroundColor: AppColors.greenAccent,
      elevation: 0,

    ),
    cardColor: AppColors.darkCard,
    colorScheme: const ColorScheme.light(
        primary: AppColors.white,
        secondary: AppColors.greenAccent,
        surface: AppColors.white
    ),


    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),

      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.white,
      ),

    ),

  );

}