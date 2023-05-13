import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/post_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'post_feed_event.dart';
part 'post_feed_state.dart';

class PostFeedBloc extends Bloc<PostFeedEvent, PostFeedState> {
  PostFeedBloc(postRepository)
      : super(PostFeedState(
          postRepository: postRepository,
        )) {
    on<LoadPostsPost>(_onLoadPosts);
    on<RefreshPosts>(_onRefreshPosts);
  }

  Future<void> _onLoadPosts(
    LoadPostsPost event,
    Emitter<PostFeedState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));

    List<Post> posts = await state.postRepository.getPostsForUser();

    emit(
      state.copyWith(
        posts: posts,
        status: PostFeedStatus.success,
      ),
    );
    event.refreshController?.loadComplete();
  }

  Future<void> _onRefreshPosts(
    RefreshPosts event,
    Emitter<PostFeedState> emit,
  ) async {
    List<Post> posts = await state.postRepository.getPostsForUser();

    emit(
      state.copyWith(
        posts: posts,
        status: PostFeedStatus.success,
      ),
    );

    event.refreshController.refreshCompleted();
  }
}
