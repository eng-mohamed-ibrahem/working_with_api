import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:working_with_api/model/user_model.dart';

final accessSharedPreference = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final saveUserAtSharedPreference =
    StateNotifierProvider<_UserStateNotifier, UserModel?>((ref) {
  return _UserStateNotifier(ref, null);
});

class _UserStateNotifier extends StateNotifier<UserModel?> {
  Ref ref;
  _UserStateNotifier(this.ref, super.state) {
    getUser();
  }

  saveUser(UserModel user) {
    ref.read(accessSharedPreference).whenData((shared) async {
      await shared.setString('user', user.toJson());
      state = user;
    });
  }

  getUser() {
    ref.read(accessSharedPreference).whenData((shared) async {
      if (shared.containsKey('user')) {
        String jsonObject = shared.getString('user')!;
        state = UserModel.fromJson(jsonDecode(jsonObject));
      } else {
        state = null;
      }
    });
  }
}
