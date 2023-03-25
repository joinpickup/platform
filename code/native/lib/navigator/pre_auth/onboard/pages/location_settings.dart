import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:location/location.dart';

class LocationSettings extends StatefulWidget {
  const LocationSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationSettings> createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardBloc, OnboardState>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                hasError: state.status == OnboardPageStatus.error,
                buttonType: CustomButtonType.outlined,
                tap: () async {
                  try {
                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {
                        return;
                      }
                    }

                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        return;
                      }
                    }
                    // ignore: empty_catches
                  } catch (e) {}
                },
                text: "Enable Location",
              ),
            ],
          ),
        );
      },
    );
  }
}
