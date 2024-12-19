import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostModel {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  PostModel({this.postId, this.id, this.name, this.email, this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}