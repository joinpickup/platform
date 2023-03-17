import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_navigator.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class InfoNavigator extends StatefulWidget {
  const InfoNavigator({Key? key}) : super(key: key);

  @override
  State<InfoNavigator> createState() => _InfoNavigatorState();
}

class _InfoNavigatorState extends State<InfoNavigator> {
  int tab = 0;
  List<String> tabs = [
    "Discover People",
    "Find Places",
    "Join Events",
    "Be You",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade700,
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  tabs[tab],
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              CustomButton(
                tap: () {
                  if (tab == tabs.length - 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OnboardNavigator(),
                      ),
                    );
                  } else {
                    setState(() {
                      tab++;
                    });
                  }
                },
                text: tab != tabs.length - 1 ? "Next" : "Get Started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
