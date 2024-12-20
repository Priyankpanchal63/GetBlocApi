import 'package:bapi/post_screen.dart';
import 'package:bapi/posts/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: PostScreen(),
      ),
    );
  }
}
