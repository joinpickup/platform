part of 'add_place_bloc.dart';

enum AddPostStatus { idle, loading, success, error }

enum AddPostErrorType { title, description, interest }

class AddPlaceState extends Equatable {
  const AddPlaceState({
    required this.postRepository,
    required this.personRepository,
    this.postID,
    this.status = AddPostStatus.loading,
    this.error,
  });

  final PostRepository postRepository;
  final PersonRepository personRepository;
  final AddPostStatus status;
  final AddPostErrorType? error;
  final int? postID;

  @override
  List<Object?> get props => [postRepository, status, error];

  AddPlaceState copyWith({
    PostRepository? postRepository,
    PersonRepository? personRepository,
    AddPostStatus? status,
    AddPostErrorType? error,
    int? postID,
  }) {
    return AddPlaceState(
      postRepository: postRepository ?? this.postRepository,
      personRepository: personRepository ?? this.personRepository,
      status: status ?? this.status,
      error: error ?? this.error,
      postID: postID ?? this.postID,
    );
  }
}
