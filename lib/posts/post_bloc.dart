import 'package:bapi/enum/post_enum.dart';
import 'package:bapi/posts/post_state.dart';
import 'package:bapi/posts/posts_event.dart';
import 'package:bapi/repository/post_repository.dart';
import 'package:bloc/bloc.dart';

import '../model/post_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();
   List<PostModel> temPostList=[];
  PostBloc() : super(const PostState()) {
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(filterList);
  }

  void fetchPostApi(event, emit)async {
     await postRepository.fetchPost().then((value) {
      emit(state.copyWith(postStatus: PostStatus.success, message: "Success",
      postList: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.failure, message: error.toString()));
    });
  }

  void filterList(event,emit)async{
    if(event.stSearch.isEmpty){
      emit(state.copyWith(temPostList: [],searchMessage: ''));
    }
    else{
      temPostList=state.postList.where((element)=>element.id.toString()==event.stSearch.toString()).toList();
      if(temPostList.isEmpty){
        emit(state.copyWith(temPostList: temPostList,searchMessage: 'No Data Found'));
      }else{
        emit(state.copyWith(temPostList: temPostList));
      }
    }

    emit(state.copyWith(temPostList: temPostList));
  }
}
