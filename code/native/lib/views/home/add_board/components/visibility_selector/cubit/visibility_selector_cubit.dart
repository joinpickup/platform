import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/theme/svg.dart';

part 'visibility_selector_state.dart';

class VisibilitySelectorCubit extends Cubit<VisibilityOption> {
  VisibilitySelectorCubit() : super(VisibilityOption.public);

  void changeOption(VisibilityOption option) => emit(option);
}
