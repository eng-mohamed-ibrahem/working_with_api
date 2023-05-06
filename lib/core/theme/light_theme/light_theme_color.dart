import 'package:flutter/material.dart';
import '../../constants/app_color_constants.dart';
import '../../constants/app_size_constants.dart';

ThemeData getThemeData() => ThemeData(
      primaryColor: AppColorConstants.primaryColor,
      appBarTheme: const AppBarTheme(color: AppColorConstants.appBarColor),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(),
      ),
      cardTheme: cardTheme(),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            AppColorConstants.backgroundColorOfElevatedButton,
          ),
        ),
      ),
      inputDecorationTheme: inputDecorationTheme(),
    );

CardTheme cardTheme() => CardTheme(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColorConstants.borderSideColor),
        borderRadius: BorderRadius.circular(AppsizeConstants.cardBorderRadius),
      ),
      margin: const EdgeInsets.only(bottom: 10),
    );

InputDecorationTheme inputDecorationTheme() => InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColorConstants.labelTextColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppsizeConstants.textFiledBorderRadius),
        borderSide: const BorderSide(
          color: AppColorConstants.textFieldBorderColor,
        ),
      ),
    );
