import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/components/modals/interests_modal/interests_modal.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/person_repository.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showAddPlaceModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return const AddNewPlaceModal();
    },
  );
}

class AddNewPlaceModal extends StatefulWidget {
  const AddNewPlaceModal({
    super.key,
  });

  @override
  State<AddNewPlaceModal> createState() => _AddNewPlaceModalState();
}

class _AddNewPlaceModalState extends State<AddNewPlaceModal> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  List<Interest>? interests;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddPostBloc(
            PostRepository(),
            PersonRepository(),
          ),
        ),
      ],
      child: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state.status == AddPostStatus.success) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Create New Place",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 26,
                                      ),
                                ),
                                CustomIconButton(
                                  child: HeroIcon(
                                    HeroIcons.xMark,
                                    style: HeroIconStyle.solid,
                                    color: TW3Colors.gray.shade300,
                                  ),
                                  tap: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                tap: () {
                                  context.read<AddPostBloc>().add(
                                        AddPost(
                                          title: _titleController.text,
                                          body: _bodyController.text,
                                          interests: interests,
                                        ),
                                      );
                                },
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
        },
      ),
    );
  }
}
