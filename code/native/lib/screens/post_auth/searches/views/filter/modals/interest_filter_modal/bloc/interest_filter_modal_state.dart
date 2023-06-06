part of 'interest_filter_modal_bloc.dart';

enum InterestsFilterModalStatus { loading, error, success }

class InterestFilterModalState extends Equatable {
  const InterestFilterModalState({
    this.allInterests,
    this.selectedInterests = const [],
    this.status = InterestsFilterModalStatus.loading,
    required this.interestRepository,
  });

  final List<Interest>? allInterests;
  final List<Interest> selectedInterests;
  final InterestsFilterModalStatus status;
  final InterestRepository interestRepository;

  @override
  List<Object?> get props => [
        allInterests,
        selectedInterests,
        status,
      ];

  InterestFilterModalState copyWith({
    List<Interest>? allInterests,
    List<Interest>? selectedInterests,
    InterestsFilterModalStatus? status,
    InterestRepository? interestRepository,
  }) {
    return InterestFilterModalState(
      allInterests: allInterests ?? this.allInterests,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      status: status ?? this.status,
      interestRepository: interestRepository ?? this.interestRepository,
    );
  }
}
