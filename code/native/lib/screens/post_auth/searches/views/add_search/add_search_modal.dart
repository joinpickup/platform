import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/screens/post_auth/searches/views/filter/filter_group.dart';
import 'package:local/screens/post_auth/searches/views/filter/filter_item.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showAddSearchModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return const FractionallySizedBox(
        heightFactor: 0.9,
        child: AddNewSearchModal(),
      );
    },
  );
}

class AddNewSearchModal extends StatefulWidget {
  const AddNewSearchModal({
    super.key,
  });

  @override
  State<AddNewSearchModal> createState() => _AddNewSearchModalState();
}

class _AddNewSearchModalState extends State<AddNewSearchModal> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Interest>? interests;

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
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Description",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: TW3Colors.gray.shade400),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CupertinoTextField(
                            controller: _descriptionController,
                            padding: const EdgeInsets.all(12),
                            onChanged: (value) {},
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            placeholder: "All posts related to tennis.",
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
                              border: null,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FilterGroup(
                        name: "Active Filters",
                        filters: [
                          FilterItem(
                            action: () {},
                            icon: HeroIcons.tag,
                            name: "Interests",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FilterGroup(
                        name: "Posible Filters",
                        filters: [
                          FilterItem(
                            action: () {},
                            icon: HeroIcons.rectangleGroup,
                            name: "Space",
                          ),
                          FilterItem(
                            action: () {},
                            icon: HeroIcons.chartBar,
                            name: "Age",
                          ),
                          FilterItem(
                            action: () {},
                            icon: HeroIcons.map,
                            name: "Distance",
                          ),
                          FilterItem(
                            action: () {},
                            icon: HeroIcons.document,
                            name: "Title",
                          ),
                          FilterItem(
                            action: () {},
                            icon: HeroIcons.documentText,
                            name: "Description",
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
                          text: "Create",
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
