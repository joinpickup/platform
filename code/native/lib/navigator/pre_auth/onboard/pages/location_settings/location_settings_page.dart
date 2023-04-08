import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/basic_info/basic_info_page_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/location_settings/location_settings_bloc.dart';

class LocationSettingsPage extends StatefulWidget {
  const LocationSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationSettingsPage> createState() => _LocationSettingsPageState();
}

class _LocationSettingsPageState extends State<LocationSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationSettingsPageBloc, LocationSettingsPageState>(
      listener: (context, state) {
        if (state.status == LocationSettingsStatus.success) {
          context.read<OnboardBloc>().add(HandleNextPage());
          context.read<LocationSettingsPageBloc>().add(ResetValidation());
        }
      },
      builder: (context, state) {
        String? name = context.read<BasicInfoPageBloc>().state.name;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
                children: [
                  const TextSpan(
                    text: "Welcome ",
                  ),
                  TextSpan(
                    text: name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  const TextSpan(text: ", please start by enabling location"),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "This app is based on your local community, therefore, we need to konw what that community is...",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            const Spacer(),
            state.locationEnabled
                ? Container()
                : SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      hasError: state.status == LocationSettingsStatus.error,
                      buttonType: CustomButtonType.outlined,
                      tap: () {
                        context
                            .read<LocationSettingsPageBloc>()
                            .add(EnableLocation());
                      },
                      text: "Enable Location",
                    ),
                  ),
            const Spacer(),
            state.locationEnabled
                ? SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "Continue",
                        tap: () {
                          context
                              .read<LocationSettingsPageBloc>()
                              .add(SubmitLocation());
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
