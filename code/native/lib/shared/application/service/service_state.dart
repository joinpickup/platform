part of 'service_bloc.dart';

enum ServiceStatus { init, loaded, error }

@immutable
sealed class ServiceState extends Equatable {
  final PocketBase? pocketBase;
  final LocaleService? localeService;
  final ServiceStatus status;

  const ServiceState({
    this.pocketBase,
    this.localeService,
    this.status = ServiceStatus.init,
  });

  @override
  List<Object?> get props => [pocketBase, localeService, status];
}

final class ServiceInitial extends ServiceState {
  const ServiceInitial() : super();
}

final class ServiceStateLoaded extends ServiceState {
  const ServiceStateLoaded({
    required super.pocketBase,
    required super.localeService,
    super.status = ServiceStatus.loaded,
  });
}
