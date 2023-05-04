import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import '../../model/user_model.dart';
import 'package:http/http.dart' as http;

final getUserProvider = StateNotifierProvider<_UserStateNotifier, UserModel?>(
    (ref) => _UserStateNotifier(null));

class _UserStateNotifier extends StateNotifier<UserModel?> {
  late List<UserModel> allUsers = [];

  _UserStateNotifier(super.state) {
    getJsonBody();
  }

  Future<List<UserModel>> getJsonBody() async {
    Response response =
        await http.get(Uri.parse('https://reqres.in/api/users'));
    try {
      if (response.statusCode == 200) {
        var users = json.decode(response.body)['data'];
        debugPrint('$users');

        for (var user in users) {
          allUsers.add(UserModel.fromJson(user));
        }
      }

      return allUsers;
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      for (var user in allUsers) {
        if (user.email == email) {
          state = user;
          break;
        }
      }
      return state;
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}
