import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_with_api/view/pages/home.dart';
import 'package:working_with_api/view/pages/login.dart';
import '../../controller/provider/save_user_at_shared_preference.dart';
import '../../controller/provider/user_api_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(saveUserAtSharedPreference.notifier).getUser().then((user) {
      log('from splash-$user');
      if (user != null) {
        log('from splash screen-$user');
        ref
            .read(getUserProvider.notifier)
            .getUserByEmail(email: user.email)
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Welcome back'),
            ),
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
              (route) => false);
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LogIn(),
            ),
            (route) => false);
      }
    });

    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
