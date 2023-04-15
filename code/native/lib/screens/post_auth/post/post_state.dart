part of 'post_bloc.dart';

enum PostStatus { loading, success, error }

enum PostCommentStatus { loading, success, error }

class PostState extends Equatable {
  const PostState({
    required this.postRepository,
    this.status = PostStatus.loading,
    this.commentStatus = PostCommentStatus.loading,
    this.post,
    this.comments,
  });

  final PostRepository postRepository;
  final PostStatus status;
  final PostCommentStatus commentStatus;
  final Post? post;
  final List<Comment>? comments;

  @override
  List<Object?> get props => [
        postRepository,
        post,
        commentStatus,
        comments,
      ];

  PostState copyWith({
    PostRepository? postRepository,
    PostStatus? status,
    PostCommentStatus? commentStatus,
    Post? post,
    List<Comment>? comments,
  }) {
    return PostState(
      postRepository: postRepository ?? this.postRepository,
      status: status ?? this.status,
      commentStatus: commentStatus ?? this.commentStatus,
      post: post ?? this.post,
      comments: comments ?? this.comments,
    );
  }
}
