import 'dart:convert';
import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final dataProvider = FutureProvider<List<dynamic>>((ref) async {
  var response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data = jsonDecode(response.body);
  log('${data.runtimeType}');
  return data; // return object from json file
});

final commentProvider = FutureProvider<List<dynamic>>((ref) async {
  var response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
  return jsonDecode(response.body);
});
