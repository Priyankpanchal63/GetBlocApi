import '../enum/post_enum.dart';
import '../model/post_model.dart';

class PostState {
  final PostStatus postStatus;
  final List<PostModel> postList;
  final List<PostModel> temPostList;
  final String message;
  final String searchMessage;

  const PostState(
      {this.postStatus = PostStatus.loading,
      this.postList = const <PostModel>[],
      this.temPostList = const <PostModel>[],
      this.message = '',
        this.searchMessage=''
      });

  PostState copyWith(
      {PostStatus? postStatus, List<PostModel>? postList,List<PostModel>?temPostList, String? message,String?searchMessage}) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      temPostList: temPostList??this.temPostList,
      message: message ?? this.message,
      searchMessage: searchMessage??this.searchMessage
    );
  }
}
