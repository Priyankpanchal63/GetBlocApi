import 'package:bapi/enum/post_enum.dart';
import 'package:bapi/posts/post_state.dart';
import 'package:bapi/posts/posts_event.dart';
import 'package:bapi/repository/post_repository.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();

  PostBloc() : super(const PostState()) {
    on<PostFetched>(fetchPostApi);
  }

  void fetchPostApi(PostFetched event, Emitter<PostState> emit)async {
     await postRepository.fetchPost().then((value) {
      emit(state.copyWith(postStatus: PostStatus.success, message: "Success",
      postList: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.faliure, message: error.toString()));
    });
  }
}
