import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tags_selector_state.dart';

class TagsSelectorCubit extends Cubit<TagsSelectorState> {
  TagsSelectorCubit() : super(TagsSelectorInitial());
}
