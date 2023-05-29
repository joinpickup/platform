import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local/components/input/button.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/screens/post_auth/post/views/post_mini.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showMessageDialog(
  BuildContext context,
  Post post,
) {
  showDialog(
    context: context,
    builder: (context) {
      return MessageDialog(
        post: post,
      );
    },
  );
}

class MessageDialog extends StatefulWidget {
  const MessageDialog({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: TW3Colors.gray.shade700,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "To ",
                  style: TextStyle(
                    color: TW3Colors.gray.shade300,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                TextSpan(
                  text: widget.post.poster.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                TextSpan(
                  text: ":",
                  style: TextStyle(
                    color: TW3Colors.gray.shade300,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito",
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          PostMini(
            post: widget.post,
          ),
          const Spacer(),
          CupertinoTextField(
            padding: const EdgeInsets.all(12),
            placeholder: "Send them a message...",
            decoration: BoxDecoration(
              color: TW3Colors.gray.shade600,
              borderRadius: BorderRadius.circular(8),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {},
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
            height: 8,
          ),
          SizedBox(
            width: double.maxFinite,
            child: CustomButton(tap: () {}, text: "Message"),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.maxFinite,
            child: CustomButton(
                buttonType: CustomButtonType.outlined,
                tap: () {
                  Navigator.of(context).pop();
                },
                text: "Cancel"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
