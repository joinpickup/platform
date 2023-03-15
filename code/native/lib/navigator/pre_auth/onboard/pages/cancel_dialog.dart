import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/navigator/pre_auth/onboard/onboard_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CancelDialog extends StatelessWidget {
  const CancelDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: TW3Colors.gray.shade700,
      insetPadding: const EdgeInsets.all(16),
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Are you sure you want to stop creating an account.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    tap: () {
                      context.read<OnboardBloc>().add(StopCancel());
                      Navigator.of(context).pop();
                    },
                    buttonType: CustomButtonType.outlined,
                    text: "Continue",
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomButton(
                    color: TW3Colors.red.shade600,
                    tap: () {
                      context.read<OnboardBloc>().add(ConfirmCancel());
                    },
                    text: "Cancel",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
