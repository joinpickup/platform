import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/input/button.dart';
import 'package:local/main.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:local/screens/post_auth/discover/views/post_options/post_options_screen.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:local/screens/post_auth/post/post_bloc.dart';
import 'package:local/screens/post_auth/post/views/message_dialog.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
    required this.postID,
  });

  final int postID;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        context.read<AddPostBloc>().state.postRepository,
      )..add(LoadPost(postID: widget.postID)),
      child: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state.status == PostStatus.success) {
            context.read<PostBloc>().add(LoadComments(postID: widget.postID));
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.success:
              return _buildSuccess(state);
            case PostStatus.loading:
              return _buildLoading();
            default:
              return _buildError();
          }
        },
      ),
    );
  }

  Scaffold _buildLoading() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Post"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.maxFinite,
          height: 175,
          color: TW3Colors.gray.shade700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 20,
                decoration: BoxDecoration(
                  color: TW3Colors.gray.shade600,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.maxFinite,
                height: 100,
                decoration: BoxDecoration(
                  color: TW3Colors.gray.shade600,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold _buildError() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Post"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Center(
          child: Text(
            "Error loading post",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  Scaffold _buildSuccess(PostState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Post"),
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              showPostOptionsModal(
                context,
              );
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: TW3Colors.gray.shade700,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildPost(
                context,
                state.post as Post,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildActions(state.post as Post),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPost(BuildContext context, Post post) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(context, post),
          const SizedBox(
            height: 8,
          ),
          Text(
            post.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            post.body,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          _buildPostFooter(context, post),
        ],
      ),
    );
  }

  Widget _buildActions(Post post) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: CustomButton(
            text: "Message",
            tap: () {
              showMessageDialog(context, post);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPostHeader(
    BuildContext context,
    Post post,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PersonScreen(
                personID: post.poster.personID,
              );
            },
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // avatar
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24),
                child: Image.asset(post.poster.avatar, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            // poster information
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                Text(
                  post.poster.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // location / visbility
                Row(
                  children: [
                    Text(
                      "East Rock",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPostFooter(BuildContext context, Post post) {
    // do some calculations here for the overflow
    int totalInterests = post.interests.length;
    List<Interest> filteredList = post.interests;

    if (totalInterests >= 2) {
      filteredList = post.interests.sublist(0, 2);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ...filteredList
                .map(
                  (e) {
                    // ignore: unnecessary_cast
                    return Column(
                      children: [
                        Text(
                          "#${e.name}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ) as Widget;
                  },
                )
                .toList()
                .insertBetween(
                  const SizedBox(
                    width: 8,
                  ),
                ),
            post.interests.length >= 3
                ? Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "+ ${post.interests.length - 3} more",
                        style: TextStyle(
                          fontSize: 12,
                          color: TW3Colors.gray.shade500,
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
        Text(
          format(post.createdAt),
          style: TextStyle(
            fontSize: 12,
            color: TW3Colors.gray.shade500,
          ),
        ),
      ],
    );
  }
}
