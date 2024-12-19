import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bapi/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com/comments";

  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        return body.map((e) {
          return PostModel(
            id: e['id'],
            postId: e['postId'],
            email: e['email'] as String,
            body: e['body'] as String,
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('Network Error: No Internet');
    } on TimeoutException {
      throw Exception('Request Timeout');
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
