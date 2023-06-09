import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_with_api/view/pages/login.dart';
import '../../controller/provider/save_user_at_shared_preference.dart';
import '../../model/user_model.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel user = ref.read(saveUserAtSharedPreference)!;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Card(
        margin: const EdgeInsets.all(20),
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: const Color.fromRGBO(56, 59, 64, 1),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Hero(
                tag: 'profile_image',
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(user.avatar),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.firstName),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(user.lastName),
                ],
              ),
              Text(user.email),
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Are you sure to Log out'),
                content: const Text(
                    'You about to logout, your data will be erased and will be downloaded again after logged in.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .watch(saveUserAtSharedPreference.notifier)
                          .clearUser()
                          .whenComplete(() {
                        // navigate to login page
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LogIn(),
                            ),
                            (route) => false);
                      });
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          );
        },
        child: const Text('Log out'),
      ),
    );
  }
}
