part of 'interests_page_bloc.dart';

enum InterestsPageStatus { error, success, initial }

class InterestsPageState extends Equatable {
  final List<Interest> interests;
  final InterestsPageStatus status;

  const InterestsPageState({
    required this.interests,
    this.status = InterestsPageStatus.initial,
  });

  @override
  List<Object?> get props => [interests, status];

  InterestsPageState copyWith({
    List<Interest>? interests,
    String? error,
    InterestsPageStatus? status,
  }) {
    return InterestsPageState(
      interests: interests ?? this.interests,
      status: status ?? this.status,
    );
  }
}
