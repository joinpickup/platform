import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class LocationSetting extends StatelessWidget {
  const LocationSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text("Location Settings"),
            const Spacer(),
            CustomButton(
              tap: () {},
              text: "Next",
            )
          ],
        ),
      ),
    );
  }
}
