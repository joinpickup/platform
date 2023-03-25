import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/location_settings.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardBloc, OnboardState>(
      listener: (context, state) => {
        if (state.status == OnboardPageStatus.success)
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const LocationSetting();
                },
              ),
            )
          }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: TW3Colors.gray.shade700,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: TW3Colors.gray.shade700,
              elevation: 0,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const Text("Basic Info"),
                  const Spacer(),
                  CustomButton(
                    tap: () {
                      context.read<OnboardBloc>().add(HandleBasicInfo());
                    },
                    text: "Next",
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
