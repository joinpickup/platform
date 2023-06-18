part of 'interest_filter_modal_bloc.dart';

enum InterestsFilterModalStatus { loading, error, success }

enum InterestsFilterModalSaveStatus { init, save }

class InterestFilterModalState extends Equatable {
  const InterestFilterModalState({
    this.allInterests,
    this.selectedInterests = const [],
    this.status = InterestsFilterModalStatus.loading,
    this.saveStatus = InterestsFilterModalSaveStatus.init,
    required this.interestRepository,
  });

  final List<Interest>? allInterests;
  final List<Interest> selectedInterests;
  final InterestsFilterModalStatus status;
  final InterestsFilterModalSaveStatus saveStatus;
  final InterestRepository interestRepository;

  @override
  List<Object?> get props => [
        allInterests,
        selectedInterests,
        status,
        saveStatus,
      ];

  InterestFilterModalState copyWith({
    List<Interest>? allInterests,
    List<Interest>? selectedInterests,
    InterestsFilterModalStatus? status,
    InterestsFilterModalSaveStatus? saveStatus,
    InterestRepository? interestRepository,
  }) {
    return InterestFilterModalState(
      allInterests: allInterests ?? this.allInterests,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      status: status ?? this.status,
      saveStatus: saveStatus ?? this.saveStatus,
      interestRepository: interestRepository ?? this.interestRepository,
    );
  }
}
