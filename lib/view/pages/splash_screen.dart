import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_with_api/view/pages/home.dart';
import 'package:working_with_api/view/pages/login.dart';
import '../../controller/provider/save_user_at_shared_preference.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(saveUserAtSharedPreference.notifier).getUser().then((user) {
      log('inside build$user');

      if (user != null) {
        log('from splash screen-$user');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Welcome back'),
          ),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(user: user),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LogIn(),
            ),
            (route) => false);
      }
    });

    return Scaffold(
      body: Image.asset(
        'assets/images/loading_image.jpg',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
