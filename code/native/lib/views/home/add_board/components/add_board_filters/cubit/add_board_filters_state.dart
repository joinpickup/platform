part of 'add_board_filters_cubit.dart';

class AddBoardFiltersState extends Equatable {
  final TagsFilterViewState tagState;

  const AddBoardFiltersState({required this.tagState});

  @override
  List<Object?> get props => [tagState];
}

const initialAddBoardFiltersState = AddBoardFiltersState(
  tagState: initialTagsFilterViewState,
);
