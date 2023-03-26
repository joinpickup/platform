import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local/components/input/button.dart';
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
              SvgPicture.asset(
                "assets/svg/donation.svg",
                height: 250,
              ),
              const Spacer(),
              Text(
                "Donate if you have the money",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "We are a small, self funded team of four. We don't want to put ads on the platform, sell user data, or give up control to investors. Servers aren't cheap so if you have the money it would help a lot.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SafeArea(
                child: Column(
                  children: [
                    CustomButton(
                      tap: () {},
                      text: "Donate",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomButton(
                      buttonType: CustomButtonType.outlined,
                      tap: () {
                        Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                        );
                      },
                      text: "Skip",
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
