import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardBloc, OnboardState>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text("Donation"),
            ],
          ),
        );
      },
    );
  }
}
