import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/constants/filters.dart';
import 'package:local/repos/data/models/post/post.dart';
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
    on<HandleSearch>(_onHandleSearch,
        transformer: (events, mapper) => events
            .debounceTime(const Duration(milliseconds: 100))
            .switchMap(mapper));
    on<ResetScreen>(_onResetSearch);

    // filters
    on<FilterPostsByAge>(_onFilterPostsByAge);
    on<ResetAgeFilterForPosts>(_onResetFiltersForPosts);
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

      // TODO: replace with api
      List<Post> posts = await state.postRepository.getPostsFromStore();
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
    await Future.delayed(const Duration(milliseconds: 100));
    emit(
      state.copyWith(
        screenStatus: DiscoverScreenStatus.init,
        feedStatus: DiscoverFeedStatus.success,
      ),
    );
  }

  Future<void> _onHandleSearch(
    HandleSearch event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.loading,
      ),
    );

    final List<Post> posts =
        await state.postRepository.searchPosts(query: event.query);

    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        postSearch: posts,
      ),
    );
  }

  Future<void> _onHandleLoadMore(
    HandleLoadMore event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    Future.delayed(const Duration(milliseconds: 300));

    // TODO: use method from API
    List<Post> newPosts = await state.postRepository.getPostsFromStore();
    List<Post> allNewPosts = [
      ...newPosts,
      ...newPosts.reversed,
      ...newPosts,
      ...newPosts.reversed,
      ...newPosts,
      ...newPosts.reversed,
    ];

    allNewPosts.shuffle();

    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        postFeed: [
          ...state.postFeed as List<Post>,
          ...allNewPosts,
        ],
      ),
    );

    event.refreshController.loadComplete();
  }

  Future<void> _onHandleRefresh(
    HandleRefresh event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    Future.delayed(const Duration(milliseconds: 300));
    List<Post> newPosts = await state.postRepository.getPostsFromStore();
    newPosts.shuffle();

    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        postFeed: [
          ...newPosts,
        ],
      ),
    );

    event.refreshController.refreshCompleted();
  }

  Future<void> _onFilterPostsByAge(
    FilterPostsByAge event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        ageFilter: DiscoverAgeFilterState(
          start: event.start,
          end: event.end,
          filterStatus: true,
        ),
      ),
    );
  }

  Future<void> _onResetFiltersForPosts(
    ResetAgeFilterForPosts event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        feedStatus: DiscoverFeedStatus.success,
        ageFilter: const DiscoverAgeFilterState(filterStatus: false),
      ),
    );
  }
}
