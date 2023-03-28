import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/post_repository.dart';

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
    on<LoadPosts>(_onLoadPosts);
    on<BeginSearch>(_onBeginSearch);
    on<ResetSearch>(_onResetSearch);
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

      List<Post> posts = await state.postRepository.getPostsFromStore();
      emit(
        state.copyWith(
          posts: posts,
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
        screenStatus: DiscoverScreenStatus.searching,
      ),
    );
  }

  Future<void> _onResetSearch(
    ResetSearch event,
    Emitter<DiscoverScreenState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(
      state.copyWith(
        screenStatus: DiscoverScreenStatus.init,
      ),
    );
  }
}
