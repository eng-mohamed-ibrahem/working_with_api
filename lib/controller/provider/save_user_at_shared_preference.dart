import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:working_with_api/model/user_model.dart';

final accessSharedPreference = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final saveUserAtSharedPreference =
    StateNotifierProvider<_UserStateNotifier, UserModel?>((ref) {
  return _UserStateNotifier(ref);
});

class _UserStateNotifier extends StateNotifier<UserModel?> {
  Ref ref;
  _UserStateNotifier(this.ref) : super(null) {
    getUser();
  }

  Future<bool> saveUser(UserModel user) async {
    log('shared -- ${user.toString()}');
    bool done = false;
    try {
      await ref.read(accessSharedPreference.future).then((shared) async {
        await shared.setString('user', jsonEncode(user.toJson()));
        state = user;
        done = true;
      });
    } on Exception catch (error) {
      state = null;
      done = false;
      debugPrint('$error');
      rethrow;
    }
    return done;
  }

  Future<UserModel?> getUser() async {
    try {
      await ref.watch(accessSharedPreference.future).then((shared) async {
        if (shared.containsKey('user')) {
          String jsonObject = shared.getString('user')!;
          state = UserModel.fromJson(
            jsonDecode(jsonObject),
          );
        } else {
          state = null;
          log('no user yet');
        }
      });
    } on Exception catch (error) {
      debugPrint('$error');
      state = null;
    }

    return state;
  }
}
