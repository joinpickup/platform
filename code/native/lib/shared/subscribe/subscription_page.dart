import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SubscriptionPopup extends StatelessWidget {
  const SubscriptionPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade700,
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/donation.svg",
              height: 250,
            ),
            const Spacer(),
            Text(
              "Join The Pickup Collective",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "We are a group of people who want to put people over profit. Joining the collective gives you voting rights on where we put our money.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      tap: () {},
                      text: "Join",
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      buttonType: CustomButtonType.outlined,
                      tap: () {
                        Navigator.of(context).pop();
                      },
                      text: "Cancel",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
