part of 'interests_modal_bloc.dart';

enum InterestsModalStatus { init, error, loading, success }

class InterestsModalState extends Equatable {
  final InterestsModalStatus status;
  final List<Interest> interests;

  const InterestsModalState({
    this.status = InterestsModalStatus.init,
    required this.interests,
  });

  @override
  List<Object?> get props => [status, interests];

  InterestsModalState copyWith({
    InterestsModalStatus? status,
    List<Interest>? interests,
  }) {
    return InterestsModalState(
      status: status ?? this.status,
      interests: interests ?? this.interests,
    );
  }
}
