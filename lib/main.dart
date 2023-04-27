import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home.dart';

void main(List<String> args) {
  runApp(const ProviderScope(
    child: MaterialApp(
      home: Home(),
    ),
  ));
}
