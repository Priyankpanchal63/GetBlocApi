import '../enum/post_enum.dart';
import '../model/post_model.dart';

class PostState {
  final PostStatus postStatus;
  final List<PostModel> postList;
  final String message;

  const PostState(
      {this.postStatus = PostStatus.loading,
      this.postList = const <PostModel>[],
      this.message = ''});

  PostState copyWith(

      {PostStatus? postStatus, List<PostModel>? postList, String? message}) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      message: message ?? this.message,
    );
  }
}
