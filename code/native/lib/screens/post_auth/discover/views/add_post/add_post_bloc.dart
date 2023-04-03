import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/person_repository.dart';
import 'package:local/repos/post_repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc(postRepository, personRepository)
      : super(AddPostState(
          postRepository: postRepository,
          personRepository: personRepository,
        )) {
    on<AddPost>(_addPost);
    on<ResetAddPostValidation>(_resetValidation);
  }

  Future<void> _addPost(
    AddPost event,
    Emitter<AddPostState> emit,
  ) async {
    if (event.title == "") {
      emit(
        state.copyWith(
          status: AddPostStatus.error,
          error: AddPostErrorType.title,
        ),
      );
    } else if (event.body == "") {
      emit(
        state.copyWith(
          status: AddPostStatus.error,
          error: AddPostErrorType.description,
        ),
      );
    } else if (event.interests == null) {
      emit(
        state.copyWith(
          status: AddPostStatus.error,
          error: AddPostErrorType.interest,
        ),
      );
    } else {
      try {
        // TODO: replace with auth repository
        Post newPost = Post(
          poster: andrew,
          interests: event.interests as List<Interest>,
          postID: 4,
          createdAt: DateTime.now(),
          title: event.title,
          body: event.body,
        );

        Post post = await state.postRepository.addPost(post: newPost);

        emit(
          state.copyWith(
            status: AddPostStatus.success,
            postID: post.postID,
          ),
        );

        emit(
          state.copyWith(
            status: AddPostStatus.idle,
            postID: null,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: AddPostStatus.error,
            error: AddPostErrorType.description,
          ),
        );
      }
    }
  }

  FutureOr<void> _resetValidation(
    ResetAddPostValidation event,
    Emitter<AddPostState> emit,
  ) {
    emit(
      state.copyWith(
        status: AddPostStatus.idle,
        error: null,
      ),
    );
  }
}
