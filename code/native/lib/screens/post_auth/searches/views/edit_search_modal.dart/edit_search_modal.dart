import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showEditSearchModal(
  BuildContext context,
  Search search,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: EditSearchModal(
          search: search,
        ),
      );
    },
  );
}

class EditSearchModal extends StatefulWidget {
  const EditSearchModal({
    super.key,
    required this.search,
  });

  final Search search;

  @override
  State<EditSearchModal> createState() => _EditSearchModalState();
}

class _EditSearchModalState extends State<EditSearchModal> {
  final _nameController = TextEditingController();

  List<Interest>? interests;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.search.name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: TW3Colors.gray.shade400),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CupertinoTextField(
                            controller: _nameController,
                            padding: const EdgeInsets.all(12),
                            placeholder: "Tennis Posts",
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {},
                            decoration: BoxDecoration(
                              color: TW3Colors.gray.shade600,
                              borderRadius: BorderRadius.circular(8),
                            ),
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
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          tap: () {},
                          text: "Edit",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
