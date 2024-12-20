import 'package:bapi/enum/post_enum.dart';
import 'package:bapi/posts/post_bloc.dart';
import 'package:bapi/posts/post_state.dart';
import 'package:bapi/posts/posts_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts APIs'),
      ),
      body: Center(
        child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return CircularProgressIndicator();

            case PostStatus.success:
              return ListView.builder(
                  itemCount: state.postList.length,
                  itemBuilder: (context, index) {
                    final item = state.postList[index];
                    return ListTile(
                      title: Text(item.email.toString()),
                      subtitle: Text(item.body.toString()),
                    );
                  });

            case PostStatus.faliure:
              return Text(state.message.toString());
          }
        }),
      ),
    );
  }
}
