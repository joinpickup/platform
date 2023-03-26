part of 'location_settings_bloc.dart';

enum LocationSettingsStatus { initial, error, success }

class LocationSettingsPageState extends Equatable {
  final LocationSettingsStatus status;
  final bool locationEnabled;

  const LocationSettingsPageState({
    this.status = LocationSettingsStatus.initial,
    this.locationEnabled = false,
  });

  @override
  List<Object?> get props => [status, locationEnabled];

  LocationSettingsPageState copyWith({
    LocationSettingsStatus? status,
    bool? locationEnabled,
  }) {
    return LocationSettingsPageState(
      status: status ?? this.status,
      locationEnabled: locationEnabled ?? this.locationEnabled,
    );
  }
}
