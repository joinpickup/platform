part of 'post_bloc.dart';

enum PostStatus { loading, success, error }

class PostState extends Equatable {
  const PostState({
    required this.postRepository,
    this.status = PostStatus.loading,
    this.post,
  });

  final PostRepository postRepository;
  final PostStatus status;
  final Post? post;

  @override
  List<Object?> get props => [postRepository, post];

  PostState copyWith({
    PostRepository? postRepository,
    PostStatus? status,
    Post? post,
  }) {
    return PostState(
      postRepository: postRepository ?? this.postRepository,
      status: status ?? this.status,
      post: post ?? this.post,
    );
  }
}
