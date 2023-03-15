import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardBloc, OnboardState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: TW3Colors.gray.shade700,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () =>
                    context.read<OnboardBloc>().add(CancelOnboarding()),
              ),
              backgroundColor: TW3Colors.gray.shade700,
              elevation: 0,
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomButton(
                    tap: () {},
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
