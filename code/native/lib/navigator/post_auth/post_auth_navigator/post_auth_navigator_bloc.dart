import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_auth_navigator_event.dart';
part 'post_auth_navigator_state.dart';

class PostAuthNavigatorBloc
    extends Bloc<PostAuthNavigatorEvent, PostAuthNavigatorState> {
  PostAuthNavigatorBloc()
      : super(
          const PostAuthNavigatorState(),
        ) {
    on<InitializePage>(_onInitializePage);
    on<ChangeTab>(_onChangeTab);
    on<UpdateBottomAppBar>(_onUpdateBottomAppBar);
  }

  Future<void> _onInitializePage(
    InitializePage event,
    Emitter<PostAuthNavigatorState> emit,
  ) async {
    emit(
      const PostAuthNavigatorState(
        tab: 0,
        showBottomAppBar: true,
      ),
    );
  }

  Future<void> _onChangeTab(
    ChangeTab event,
    Emitter<PostAuthNavigatorState> emit,
  ) async {
    emit(
      PostAuthNavigatorState(
        tab: event.tab,
      ),
    );
  }

  Future<void> _onUpdateBottomAppBar(
    UpdateBottomAppBar event,
    Emitter<PostAuthNavigatorState> emit,
  ) async {
    emit(
      PostAuthNavigatorState(
        showBottomAppBar: event.showBottomAppBar,
      ),
    );
  }
}
