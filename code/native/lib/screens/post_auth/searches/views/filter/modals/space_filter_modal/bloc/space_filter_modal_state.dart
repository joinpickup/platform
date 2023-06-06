part of 'space_filter_modal_bloc.dart';

enum SpaceFilterModalStatus { loading, error, success }

@immutable
class SpaceFilterModalState extends Equatable {
  const SpaceFilterModalState({
    this.allSpaces,
    this.status = SpaceFilterModalStatus.loading,
    this.selectedSpaces = const [],
    required this.spaceRepository,
  });

  final List<Space>? allSpaces;
  final List<Space> selectedSpaces;
  final SpaceFilterModalStatus status;
  final SpaceRepository spaceRepository;

  SpaceFilterModalState copyWith({
    List<Space>? allSpaces,
    List<Space>? selectedSpaces,
    SpaceFilterModalStatus? status,
    SpaceRepository? spaceRepository,
  }) {
    return SpaceFilterModalState(
      allSpaces: allSpaces ?? this.allSpaces,
      selectedSpaces: selectedSpaces ?? this.selectedSpaces,
      status: status ?? this.status,
      spaceRepository: spaceRepository ?? this.spaceRepository,
    );
  }

  @override
  List<Object?> get props => [
        allSpaces,
        selectedSpaces,
        status,
        spaceRepository,
      ];
}
