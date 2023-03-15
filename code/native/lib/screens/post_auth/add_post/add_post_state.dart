part of 'add_post_bloc.dart';

enum AddPostStatus { idle, loading, success, error }

class AddPostState extends Equatable {
  const AddPostState({
    required this.postRepository,
    required this.personRepository,
    this.postID,
    this.status = AddPostStatus.loading,
  });

  final PostRepository postRepository;
  final PersonRepository personRepository;
  final AddPostStatus status;
  final int? postID;

  @override
  List<Object?> get props => [postRepository, status];

  AddPostState copyWith({
    PostRepository? postRepository,
    PersonRepository? personRepository,
    AddPostStatus? status,
    int? postID,
  }) {
    return AddPostState(
      postRepository: postRepository ?? this.postRepository,
      personRepository: personRepository ?? this.personRepository,
      status: status ?? this.status,
      postID: postID ?? this.postID,
    );
  }
}
