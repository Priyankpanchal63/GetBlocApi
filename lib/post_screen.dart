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
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched()); // Load all posts initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts APIs'),
      ),
      body: Center(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            switch (state.postStatus) {
              case PostStatus.loading:
                return Center(child: CircularProgressIndicator());

              case PostStatus.success:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search with Email",
                          border: OutlineInputBorder(),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context.read<PostBloc>().add(PostFetched());
                            },
                          )
                              : null,
                        ),
                        onChanged: (filterKey) {
                          if (filterKey.isEmpty) {
                            context.read<PostBloc>().add(PostFetched());
                          } else {
                            context.read<PostBloc>().add(SearchItem(filterKey));
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: state.temPostList.isEmpty &&
                          state.postList.isEmpty
                          ? Center(child: Text('No posts available'))
                          : ListView.builder(
                        itemCount: (state.temPostList.isNotEmpty
                            ? state.temPostList.length
                            : state.postList.length) >
                            0
                            ? (state.temPostList.isNotEmpty
                            ? state.temPostList.length
                            : state.postList.length)
                            : 0,
                        itemBuilder: (context, index) {
                          var item = state.temPostList.isNotEmpty
                              ? state.temPostList[index]
                              : state.postList[index];
                          return Card(
                            child: ListTile(
                              title: Text(item.email ?? 'No Email'),
                              subtitle: Text(item.body ?? 'No Body'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );

              case PostStatus.failure:
                return Center(child: Text(state.message.isEmpty ? 'Unknown Error' : state.message));

              default:
                return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
