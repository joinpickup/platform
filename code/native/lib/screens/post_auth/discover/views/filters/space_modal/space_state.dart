part of 'space_bloc.dart';

enum SpaceStatus { loading, init, success, error }

enum SpaceInterestsStatus { loading, init, success, error }

class SpaceState extends Equatable {
  final List<Space>? spaces;
  final Space? space;
  final List<Interest>? interests;
  final SpaceStatus spaceStatus;
  final SpaceInterestsStatus interestsStatus;
  final SpaceRepository spaceRepository;

  const SpaceState({
    this.spaces,
    this.space,
    this.interests,
    this.spaceStatus = SpaceStatus.init,
    this.interestsStatus = SpaceInterestsStatus.init,
    required this.spaceRepository,
  });

  @override
  List<Object?> get props =>
      [spaces, spaceStatus, space, interests, interestsStatus];

  SpaceState copyWith({
    List<Space>? spaces,
    Space? space,
    List<Interest>? interests,
    SpaceStatus? spaceStatus,
    SpaceInterestsStatus? interestsStatus,
    SpaceRepository? spaceRepository,
  }) {
    return SpaceState(
      spaces: spaces ?? this.spaces,
      space: space ?? this.space,
      interests: interests ?? this.interests,
      spaceStatus: spaceStatus ?? this.spaceStatus,
      interestsStatus: interestsStatus ?? this.interestsStatus,
      spaceRepository: spaceRepository ?? this.spaceRepository,
    );
  }
}
