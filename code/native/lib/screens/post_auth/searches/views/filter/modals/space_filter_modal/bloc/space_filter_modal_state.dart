part of 'space_filter_modal_bloc.dart';

enum SpaceFilterModalStatus { loading, error, success }

enum SpaceFilterModalSaveStatus { init, save }

@immutable
class SpaceFilterModalState extends Equatable {
  const SpaceFilterModalState({
    this.allSpaces,
    this.selectedSpaces = const [],
    this.status = SpaceFilterModalStatus.loading,
    this.saveStatus = SpaceFilterModalSaveStatus.init,
    required this.spaceRepository,
  });

  final List<Space>? allSpaces;
  final List<Space> selectedSpaces;
  final SpaceFilterModalStatus status;
  final SpaceRepository spaceRepository;
  final SpaceFilterModalSaveStatus saveStatus;

  SpaceFilterModalState copyWith({
    List<Space>? allSpaces,
    List<Space>? selectedSpaces,
    SpaceFilterModalStatus? status,
    SpaceRepository? spaceRepository,
    SpaceFilterModalSaveStatus? saveStatus,
  }) {
    return SpaceFilterModalState(
      allSpaces: allSpaces ?? this.allSpaces,
      selectedSpaces: selectedSpaces ?? this.selectedSpaces,
      status: status ?? this.status,
      spaceRepository: spaceRepository ?? this.spaceRepository,
      saveStatus: saveStatus ?? this.saveStatus,
    );
  }

  @override
  List<Object?> get props => [
        allSpaces,
        selectedSpaces,
        status,
        saveStatus,
        spaceRepository,
      ];
}
