import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/pages/basic_info.dart';
import 'package:local/navigator/pre_auth/onboard/pages/location_settings.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class OnboardNavigator extends StatefulWidget {
  const OnboardNavigator({Key? key}) : super(key: key);

  @override
  State<OnboardNavigator> createState() => _OnboardNavigatorState();
}

class _OnboardNavigatorState extends State<OnboardNavigator> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardBloc>(
      create: (context) => OnboardBloc(),
      child: BlocBuilder<OnboardBloc, OnboardState>(
        builder: (context, state) {
          return const BasicInfo();
        },
      ),
    );
  }
}
