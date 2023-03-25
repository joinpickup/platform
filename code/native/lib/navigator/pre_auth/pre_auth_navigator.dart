import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/login/login_screen.dart';
import 'package:local/navigator/pre_auth/onboard/info_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PreAuthNavigator extends StatefulWidget {
  const PreAuthNavigator({Key? key}) : super(key: key);

  @override
  State<PreAuthNavigator> createState() => _PreAuthNavigatorState();
}

class _PreAuthNavigatorState extends State<PreAuthNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade700,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/pickup-logo.png",
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    "Local",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomButton(
                    tap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const InfoScreen();
                        },
                      ));
                    },
                    text: "Continue",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                    buttonType: CustomButtonType.outlined,
                    tap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ));
                    },
                    text: "Log In",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
