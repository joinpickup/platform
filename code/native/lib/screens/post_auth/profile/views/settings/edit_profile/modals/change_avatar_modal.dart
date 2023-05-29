import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showChangeAvatarModal(
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
      return const ChangeAvatarModal();
    },
  );
}

class ChangeAvatarModal extends StatefulWidget {
  const ChangeAvatarModal({
    super.key,
  });

  @override
  State<ChangeAvatarModal> createState() => _ChangeAvatarModalState();
}

class _ChangeAvatarModalState extends State<ChangeAvatarModal> {
  var selected = 0;

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
                    "Avatars",
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 16, // Horizontal spacing between items
                children: List.generate(
                  20,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                        border: selected == index
                            ? Border.all(
                                color: Colors.orange.shade300,
                                width: 2,
                                style: BorderStyle.solid,
                              )
                            : const Border(),
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 16,
                      ), // Vertical spacing between rows
                    ),
                  ),
                ),
              ),
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
