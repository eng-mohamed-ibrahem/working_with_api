import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_with_api/view/pages/home.dart';
import 'package:working_with_api/view/pages/login.dart';
import '../../controller/provider/connectivity_provider.dart';
import '../../controller/provider/save_user_at_shared_preference.dart';
import '../../controller/provider/user_api_provider.dart';
import '../widget/connection_dialog.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(connectivityProvider); // required to rebuild after changing state
    ref.watch(connectivityProvider.notifier).checkConnection().then((result) {
      /// chech if connected to the internet
      if (ref.watch(connectivityProvider.notifier).isConnected()) {
        /// get data from api
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
      }
    });

    log('2');

    /// loading
    return Scaffold(
      body: ref.watch(connectivityProvider.notifier).isConnected()
          ? Image.asset(
              'assets/images/loading_image.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : const ConnectionDialog(),
    );
  }
}
