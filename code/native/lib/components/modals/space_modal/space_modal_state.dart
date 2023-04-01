part of 'space_modal_bloc.dart';

enum SpaceModalStatus { loading, init, success, error }

class SpaceModalState extends Equatable {
  final List<Space>? spaces;
  final SpaceModalStatus status;

  const SpaceModalState({
    this.spaces,
    this.status = SpaceModalStatus.init,
  });

  @override
  List<Object?> get props => [spaces, status];

  SpaceModalState copyWith({
    List<Space>? spaces,
    SpaceModalStatus? status,
  }) {
    return SpaceModalState(
      spaces: spaces ?? this.spaces,
      status: status ?? this.status,
    );
  }
}
