import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/discover/views/discover_search/discover_search.dart';
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
    on<SearchPosts>(_onSearchPosts);
  }

  Future<void> _onLoadPosts(
    LoadPostsPost event,
    Emitter<PostFeedState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final posts = await state.postRepository.getPostsFromStore();
    posts.sort(
      (a, b) => b.createdAt.difference(a.createdAt).inMilliseconds,
    );

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
    await Future.delayed(const Duration(milliseconds: 250));
    final posts = await state.postRepository.getPostsFromStore();
    posts.sort(
      (a, b) => b.createdAt.difference(a.createdAt).inMilliseconds,
    );

    emit(
      state.copyWith(
        posts: posts,
        status: PostFeedStatus.success,
      ),
    );

    event.refreshController.refreshCompleted();
  }

  Future<void> _onSearchPosts(
    SearchPosts event,
    Emitter<PostFeedState> emit,
  ) async {
    Navigator.of(event.context).push(
      MaterialPageRoute(
        builder: (context) => DiscoverSearch(
          search: event.query,
        ),
      ),
    );

    emit(
      state.copyWith(
        posts: state.posts,
        status: PostFeedStatus.success,
      ),
    );
  }
}
