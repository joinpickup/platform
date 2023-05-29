import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showChangeUsernameModal(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    builder: (context) {
      return const ChangeUsernameModal();
    },
  );
}

class ChangeUsernameModal extends StatefulWidget {
  const ChangeUsernameModal({
    super.key,
  });

  @override
  State<ChangeUsernameModal> createState() => _ChangeUsernameModalState();
}

class _ChangeUsernameModalState extends State<ChangeUsernameModal> {
  var selected = 0;
  var hasError = false;
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TW3Colors.gray.shade500,
                ),
                width: 64,
                height: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 26,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CupertinoTextField(
              controller: _usernameController,
              placeholder: "Enter a new username...",
              padding: const EdgeInsets.all(12),
              placeholderStyle: TextStyle(
                color: TW3Colors.gray.shade400,
                fontFamily: "Nunito",
              ),
              style: TextStyle(
                color: TW3Colors.gray.shade300,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold,
              ),
              decoration: BoxDecoration(
                  color: TW3Colors.gray.shade600,
                  borderRadius: BorderRadius.circular(8),
                  border: hasError
                      ? Border.all(
                          color: TW3Colors.red.shade500,
                          width: 2,
                        )
                      : null),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                buttonType: CustomButtonType.contained,
                tap: () {},
                text: "Update",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
