import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/post.dart';
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
  }

  Future<void> _addPost(
    AddPost event,
    Emitter<AddPostState> emit,
  ) async {
    Post newPost = event.post;
    newPost.poster = await state.personRepository.getPerson(
      personID: newPost.posterID,
    );

    Post post = await state.postRepository.addPost(post: event.post);

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
  }
}
