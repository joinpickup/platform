import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/home/add_board/add_board.dart';
import 'package:local/views/home/add_post/add_post.dart';

Future<dynamic> showAddDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 150),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return const SafeArea(
        child: AddDialog(),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: const Offset(0.0, 0.0),
        ).animate(anim1),
        child: child,
      );
    },
  );
}

class AddDialog extends StatelessWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kColorSand,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddItem(
              title: "New Post",
              icon: kIconPost,
              description:
                  "Share an event, idea, suggestion or whatever you want to connect with people.",
              tap: () {
                showAddPost(context);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            AddItem(
              title: "New Board",
              icon: kIconBoard,
              description: "Find posts for the things that you love.",
              tap: () {
                showAddBoard(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddItem extends StatefulWidget {
  const AddItem({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor,
    required this.description,
    required this.tap,
  }) : super(key: key);

  final String title;
  final String icon;
  final Color? iconColor;
  final String description;
  final Function tap;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        widget.tap();
      },
      onTapDown: (details) {
        setState(() {
          hovered = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          hovered = false;
        });
      },
      onTapCancel: () {
        setState(() {
          hovered = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: hovered ? kColorInput.shade300 : Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              child: SvgPicture.string(
                widget.icon,
                height: 24,
                width: 24,
                theme: SvgTheme(
                  currentColor: widget.iconColor ?? kColorRoyal,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    widget.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: kColorRoyal.shade200),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
