import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/interest_repository.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/bloc/interest_filter_modal_bloc.dart';
import 'package:local/screens/post_auth/searches/views/filter/modals/interest_filter_modal/interest_filter_modal.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showAddPostModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    isDismissible: false,
    enableDrag: false,
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (_) {
      return const FractionallySizedBox(
        heightFactor: 0.9,
        child: AddNewPostModal(),
      );
    },
  );
}

class AddNewPostModal extends StatefulWidget {
  const AddNewPostModal({
    super.key,
  });

  @override
  State<AddNewPostModal> createState() => _AddNewPostModalState();
}

class _AddNewPostModalState extends State<AddNewPostModal> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  List<Interest>? interests;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InterestFilterModalBloc(
        InterestRepository(),
      )..add(LoadIntersts()),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Create New Post",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 22,
                                  ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: TW3Colors.gray.shade400),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              CupertinoTextField(
                                controller: _titleController,
                                padding: const EdgeInsets.all(12),
                                placeholder: "Looking for a tennis partner...",
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (value) {
                                  context
                                      .read<AddPostBloc>()
                                      .add(ResetAddPostValidation());
                                },
                                decoration: BoxDecoration(
                                    color: TW3Colors.gray.shade600,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        state.status == AddPostStatus.error &&
                                                state.error ==
                                                    AddPostErrorType.title
                                            ? Border.all(
                                                color: TW3Colors.red.shade500,
                                                width: 2,
                                              )
                                            : null),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                controller: _bodyController,
                                padding: const EdgeInsets.all(12),
                                onChanged: (value) {
                                  context
                                      .read<AddPostBloc>()
                                      .add(ResetAddPostValidation());
                                },
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                placeholder:
                                    "I typically play on the courts nearby Main Street, I'm not very good so you don't have to be either...",
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
                                    border:
                                        state.status == AddPostStatus.error &&
                                                state.error ==
                                                    AddPostErrorType.description
                                            ? Border.all(
                                                color: TW3Colors.red.shade500,
                                                width: 2,
                                              )
                                            : null),
                                maxLines: 6,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Interest",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: TW3Colors.gray.shade400),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AddPostBloc>()
                                      .add(ResetAddPostValidation());
                                  showInterestFilterModal(context);
                                },
                                child: Container(
                                  height: 46,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: TW3Colors.gray.shade600,
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          state.status == AddPostStatus.error &&
                                                  state.error ==
                                                      AddPostErrorType.interest
                                              ? Border.all(
                                                  color: TW3Colors.red.shade500,
                                                  width: 2,
                                                )
                                              : null),
                                  child: Text(
                                    interests == null
                                        ? "#Tennis"
                                        : interests!
                                            .map((e) {
                                              return "#${e.name}";
                                            })
                                            .toList()
                                            .join(", "),
                                    style: TextStyle(
                                      color: interests == null
                                          ? TW3Colors.gray.shade500
                                          : TW3Colors.gray.shade300,
                                      fontSize: 16,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                      text: "Post",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
