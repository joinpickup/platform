import 'package:flutter/material.dart';
import 'package:local/screens/post_auth/messages/chat_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ChatThread extends StatefulWidget {
  const ChatThread({Key? key}) : super(key: key);

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends State<ChatThread> {
  bool selected = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const body =
        "Hey man really looking forward to saturday, its going to be a lot of fun";

    return GestureDetector(
      onTapDown: (details) {
        if (mounted) {
          setState(() {
            selected = true;
          });
        }
      },
      onTap: () {
        if (mounted) {
          setState(() {
            selected = true;
          });
        }
        Future.delayed(const Duration(milliseconds: 50), () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const ChatScreen();
            },
          ));
        });
      },
      onTapUp: (details) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              selected = false;
            });
          }
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              selected = false;
            });
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selected ? TW3Colors.gray.shade600 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(20),
                child:
                    Image.asset("assets/avatars/fox_ai.png", fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Andrew",
                      style: Theme.of(context).textTheme.bodyLarge,
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
                    const SizedBox(
                      width: 8,
                    ),
                    Text("3 minutes ago",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                Text(
                  body.length <= 50 ? body : "${body.substring(0, 50)}...",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: TW3Colors.gray.shade400),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
