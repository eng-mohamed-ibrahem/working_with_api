import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_with_api/view/pages/login.dart';
import 'core/theme/light_theme/light_theme_color.dart';


void main(List<String> args) {
  runApp(ProviderScope(
    child: MaterialApp(
      theme: getThemeData(),
      home: const LogIn(), 
    ),
  ));
}
