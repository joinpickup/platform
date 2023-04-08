import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

part 'location_settings_event.dart';
part 'location_settings_state.dart';

class LocationSettingsPageBloc
    extends Bloc<LocationSettingsPageEvent, LocationSettingsPageState> {
  LocationSettingsPageBloc() : super(const LocationSettingsPageState()) {
    on<EnableLocation>(_onEnableLocation);
    on<ResetValidation>(_onResetValidation);
    on<SubmitLocation>(_onSubmitLocation);
  }

  Future<void> _onEnableLocation(
    EnableLocation event,
    Emitter<LocationSettingsPageState> emit,
  ) async {
    Location location = Location();
    late bool serviceEnabled;

    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }

      // ignore: empty_catches
    } catch (e) {
      emit(
        state.copyWith(
          status: LocationSettingsStatus.error,
          locationEnabled: false,
        ),
      );
    }

    emit(
      state.copyWith(
        locationEnabled: serviceEnabled,
      ),
    );
  }

  Future<void> _onSubmitLocation(
    SubmitLocation event,
    Emitter<LocationSettingsPageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: LocationSettingsStatus.success,
      ),
    );
  }

  Future<void> _onResetValidation(
    ResetValidation event,
    Emitter<LocationSettingsPageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: LocationSettingsStatus.initial,
      ),
    );
  }
}
