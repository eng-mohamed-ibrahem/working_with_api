import 'package:flutter/material.dart';
import '../../constants/app_color_constants.dart';

ThemeData getThemeData() => ThemeData(
      primaryColor: AppColorConstants.primaryColor,
      appBarTheme: const AppBarTheme(color: AppColorConstants.appBarColor),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(),
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColorConstants.borderSideColor),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 10),
      ),
    );
