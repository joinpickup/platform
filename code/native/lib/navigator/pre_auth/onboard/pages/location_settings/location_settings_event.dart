part of 'location_settings_bloc.dart';

abstract class LocationSettingsPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EnableLocation extends LocationSettingsPageEvent {}

class ResetValidation extends LocationSettingsPageEvent {}

class SubmitLocation extends LocationSettingsPageEvent {}
