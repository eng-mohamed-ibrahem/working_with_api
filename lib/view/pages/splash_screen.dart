import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/provider/save_user_at_shared_preference.dart';
import '../../model/user_model.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(saveUserAtSharedPreference);
    if (user != null) {
      // TODO get user by email
      // TODO Navigate to Home
    } else {
      // TODO Navigate to Login
    }
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/loading_image.jpg'),
        ),
      ),
    );
  }
}
