import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'basic_info_page_event.dart';
part 'basic_info_page_state.dart';

class BasicInfoPageBloc extends Bloc<BasicInfoPageEvent, BasicInfoPageState> {
  BasicInfoPageBloc() : super(const BasicInfoPageState()) {
    on<SubmitBasicInfo>(_onSubmitBasicInfo);
    on<ResetBasicInfoValidation>(_onResetValidation);
  }

  Future<void> _onSubmitBasicInfo(
    SubmitBasicInfo event,
    Emitter<BasicInfoPageState> emit,
  ) async {
    if (event.name == "") {
      emit(
        state.copyWith(
          error: BasicInfoPageError.name,
          status: BasicInfoPageStatus.error,
        ),
      );
    } else if (event.birthday == null) {
      emit(
        state.copyWith(
          error: BasicInfoPageError.birthday,
          status: BasicInfoPageStatus.error,
        ),
      );
    } else {
      emit(
        state.copyWith(
          name: event.name,
          birthday: event.birthday,
          status: BasicInfoPageStatus.success,
        ),
      );
    }
  }

  Future<void> _onResetValidation(
    ResetBasicInfoValidation event,
    Emitter<BasicInfoPageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BasicInfoPageStatus.initial,
      ),
    );
  }
}
