import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/views/home/add_board/components/add_board_filters/presentation/tab_views/tags_filter_view/cubit/tags_filter_view_cubit.dart';

part 'add_board_filters_state.dart';

class AddBoardFiltersCubit extends Cubit<AddBoardFiltersState> {
  AddBoardFiltersCubit() : super(initialAddBoardFiltersState);

  void updateAddBoardFiltersState(AddBoardFiltersState newState) =>
      emit(newState);
}
