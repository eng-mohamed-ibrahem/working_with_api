import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/theme/light_theme/light_theme_color.dart';
import 'view/pages/home.dart';

void main(List<String> args) {
  runApp(ProviderScope(
    child: MaterialApp(
      theme: getThemeData(),
      home: const Home(),
    ),
  ));
}
