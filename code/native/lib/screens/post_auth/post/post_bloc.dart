import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/post.dart';
import 'package:local/repos/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(postRepository) : super(PostState(postRepository: postRepository)) {
    on<LoadPost>(_onLoadPost);
  }

  Future<void> _onLoadPost(
    LoadPost event,
    Emitter<PostState> emit,
  ) async {
    Post? post = await state.postRepository.getPost(postID: event.postID);
    print(post);

    if (post == null) {
      emit(state.copyWith(
        post: post,
        status: PostStatus.error,
      ));
    }

    emit(state.copyWith(
      post: post,
      status: PostStatus.success,
    ));
  }
}
