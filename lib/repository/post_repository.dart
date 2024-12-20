import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bapi/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com/comments";

  Future<List<PostModel>> fetchPost() async {
    try {
      final reposnse = await http.get(Uri.parse(baseUrl));

      if (reposnse.statusCode == 200) {
        final body = jsonDecode(reposnse.body) as List;
        return body.map((e) {
          return PostModel(
            postId: e['postId'],
            email: e['email'] as String,
            body: e['body'] as String,
          );
        }).toList();
      }
    } on SocketException {
      throw Exception('Error while Fetching Data');
    } on TimeoutException {
      throw Exception('Error while Fetching Data');
    }

    throw Exception('Error while Fetching Data');
  }
}
