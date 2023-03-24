import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/mocks/interest.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/add_post/add_post_bloc.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // state for post
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  PostVisibility? visibility = PostVisibility.public;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Add Post",
          ),
          backgroundColor: TW3Colors.gray.shade700,
        ),
        backgroundColor: TW3Colors.gray.shade700,
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<AddPostBloc, AddPostState>(
      listener: (context, state) {
        if (state.status == AddPostStatus.success) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        height: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            ListView(
              children: [
                Text(
                  "Post Information",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                CupertinoTextField(
                  controller: _titleController,
                  placeholder: "Enter a title...",
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
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CupertinoTextField(
                  controller: _bodyController,
                  placeholder: "Enter a body...",
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
                  ),
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Post Visibility",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  dropdownColor: TW3Colors.gray.shade800,
                  decoration: InputDecoration(
                    fillColor: TW3Colors.gray.shade600,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  value: visibility,
                  onChanged: (value) {
                    setState(() {
                      visibility = value;
                    });
                  },
                  items: PostVisibility.values
                      .map((value) => DropdownMenuItem(
                            key: Key(value.name),
                            value: value,
                            child: Text(
                              value.name[0].toUpperCase() +
                                  value.name.substring(1),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Interest",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Group",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Group",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomButton(
                tap: () {
                  context.read<AddPostBloc>().add(
                        AddPost(
                          post: Post(
                            visibility: visibility as PostVisibility,
                            title: _titleController.text,
                            body: _bodyController.text,
                            createdAt: DateTime.now(),
                            interestID: 1,
                            interest: rockClimbingInterest,
                            // TODO: fix this
                            posterID:
                                context.read<AuthBloc>().state.user!.userID,
                          ),
                        ),
                      );
                },
                text: "Next",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
