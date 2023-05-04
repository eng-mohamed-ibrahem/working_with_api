import 'dart:convert';
import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:working_with_api/model/user_model.dart';

final accessSharedPreference = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final saveUserAtSharedPreference =
    StateNotifierProvider<_UserStateNotifier, AsyncValue<UserModel?>>((ref) {
  return _UserStateNotifier(ref, const AsyncValue.loading());
});

class _UserStateNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  Ref ref;
  _UserStateNotifier(this.ref, super.state) {
    getUser();
  }

  Future<bool> saveUser(UserModel user) async {
    log('shared -- ${user.toString()}');
    bool done = false;
    try {
      await ref.read(accessSharedPreference.future).then((shared) async {
        await shared.setString('user', jsonEncode(user.toJson()));
        state = AsyncValue.data(user);
        done = true;
      });
    } on Exception catch (error, stackTrack) {
      state = AsyncValue.error(error, stackTrack);
      done = false;
      rethrow;
    }
    return done;
  }

  Future<AsyncValue<UserModel?>> getUser() async {
    state = const AsyncValue.loading();
    try {
      await ref.watch(accessSharedPreference.future).then((shared) async {
        if (shared.containsKey('user')) {
          String jsonObject = shared.getString('user')!;
          state = AsyncValue.data(
            UserModel.fromJson(
              jsonDecode(jsonObject),
            ),
          );
        } else {
          state = const AsyncValue.data(null);
          log('no user yet');
        }
      });
    } on Exception catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }

    return state;
  }
}
