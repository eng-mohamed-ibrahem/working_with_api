import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../controller/provider/save_user_at_shared_preference.dart';
import '../../controller/provider/user_api_provider.dart';
import '../../model/user_model.dart';
import 'home.dart';

class LogIn extends HookConsumerWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(saveUserAtSharedPreference);

    ref.watch(getUserProvider);
    final TextEditingController emailController = useTextEditingController();
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          color: const Color.fromRGBO(56, 59, 64, 1),
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: const Color.fromRGBO(56, 59, 64, 1),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/be_live_logo.jpg',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: Color.fromRGBO(42, 148, 121, 1),
                      ),
                      cursorColor: const Color.fromRGBO(42, 148, 121, 1),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(42, 148, 121, 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(56, 59, 64, 1),
                          ),
                        ),
                        labelText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email cannot left be blank';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(56, 59, 64, 1),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // TODO save user to sharedPreference
                          // get users from api and check if it already exist or not
                          await ref
                              .watch(getUserProvider.notifier)
                              .getUserByEmail(emailController.text.trim())
                              .then(
                            (user) {
                              if (user != null &&
                                  user.email == emailController.text.trim()) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid email'),
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
