import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local/features/locale/application/locale_service.dart';
import 'package:local/features/locale/data/locale_repository.dart';
import 'package:meta/meta.dart';
import 'package:pocketbase/pocketbase.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(const ServiceInitial()) {
    on<LoadServices>((event, emit) {
      final pocketBase = event.pocketbase;

      // setup locale service
      final localeRepository = HttpLocaleRepository(pocketBase: pocketBase);
      final localeService = LocaleService(localeRepository);

      emit(
        ServiceStateLoaded(
          pocketBase: event.pocketbase,
          localeService: localeService,
        ),
      );
    });
  }
}
