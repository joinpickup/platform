import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showEditBioModal(
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
      return const FractionallySizedBox(
        heightFactor: 0.7,
        child: EditBioModal(),
      );
    },
  );
}

class EditBioModal extends StatefulWidget {
  const EditBioModal({
    super.key,
  });

  @override
  State<EditBioModal> createState() => _EditBioModalState();
}

class _EditBioModalState extends State<EditBioModal> {
  var selected = 0;
  var hasError = false;
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      "Bio",
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
                controller: _bioController,
                padding: const EdgeInsets.all(12),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                placeholder: "Enter a new bio...",
                placeholderStyle: TextStyle(
                  color: TW3Colors.gray.shade500,
                  fontSize: 16,
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
                maxLines: 6,
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
      ),
    );
  }
}
