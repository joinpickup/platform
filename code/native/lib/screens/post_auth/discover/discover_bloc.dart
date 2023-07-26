import 'dart:async';
import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/repos/post_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverScreenBloc
    extends Bloc<DiscoverScreenEvent, DiscoverScreenState> {
  DiscoverScreenBloc(postRepository)
      : super(
          DiscoverScreenState(
            postRepository: postRepository,
          ),
        ) {
    // loading
    on<LoadPosts>(_onLoadPosts);
    on<HandleLoadMore>(_onHandleLoadMore);
    on<HandleRefresh>(_onHandleRefresh);

    // search
    on<BeginSearch>(_onBeginSearch);
    on<ResetScreen>(_onResetSearch);

    on<SearchPosts>(_onSearchPosts,
        transformer: (events, mapper) => events
            .debounceTime(const Duration(milliseconds: 100))
            .switchMap(mapper));
  }

  Future<void> _onLoadPosts(
    LoadPosts event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          feedStatus: DiscoverFeedStatus.loading,
        ),
      );

      List<Post> posts = await state.postRepository.getPostsForUser();
      emit(
        state.copyWith(
          postFeed: posts,
          feedStatus: DiscoverFeedStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: DiscoverScreenError(
            e.toString(),
            DiscoverScreenErrorType.loading,
          ),
          feedStatus: DiscoverFeedStatus.error,
        ),
      );
    }
  }

  Future<void> _onBeginSearch(
    BeginSearch event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 100));

    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.loading,
        screenStatus: DiscoverScreenStatus.searching,
      ),
    );
  }

  Future<void> _onResetSearch(
    ResetScreen event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.loading,
      ),
    );

    List<Post> posts = await state.postRepository.searchPosts(
      "",
      event.interests,
      event.spaces,
    );

    emit(
      state.copyWith(
        screenStatus: DiscoverScreenStatus.init,
        feedStatus: DiscoverFeedStatus.success,
        searchQuery: "",
        interestsFilter: event.interests,
        spacesFilter: event.spaces,
        postSearch: posts,
        postFeed: posts,
      ),
    );
  }

  Future<void> _onSearchPosts(
    SearchPosts event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.loading,
      ),
    );

    List<Post> posts = await state.postRepository.searchPosts(
      event.query,
      event.interests,
      event.spaces,
    );

    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        searchQuery: event.query,
        interestsFilter: event.interests,
        spacesFilter: event.spaces,
        postSearch: posts,
        postFeed: posts,
      ),
    );
  }

  Future<void> _onHandleLoadMore(
    HandleLoadMore event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.loading,
      ),
    );

    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        postFeed: [
          ...state.postFeed as List<Post>,
        ],
      ),
    );

    event.refreshController.loadComplete();
  }

  Future<void> _onHandleRefresh(
    HandleRefresh event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.loading,
      ),
    );

    List<Post> posts = await state.postRepository.searchPosts(
      event.query,
      event.interests,
      event.spaces,
    );

    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        postFeed: posts,
      ),
    );

    event.refreshController.refreshCompleted();
  }
}
