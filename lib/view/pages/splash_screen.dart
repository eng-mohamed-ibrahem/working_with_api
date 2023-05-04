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
    final user = ref.watch(saveUserAtSharedPreference);
    log('inside build$user');

    /// threr is something error here
    return user.when(data: (user) {
      log('from splash screen-$user');
      if (user != null) {
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
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LogIn(),
            ),
            (route) => false);
      }
      return const SizedBox();
    }, error: (error, stackTrace) {
      return const Center(
        child: Text('Oops, there something unexpected happened'),
      );
    }, loading: () {
      return Center(
        child: Image.asset('assets/images/loading_image.jpg'),
        // child: CircularProgressIndicator(),
      );
    });
  }
}
