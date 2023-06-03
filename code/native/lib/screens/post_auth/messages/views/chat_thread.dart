import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/message/thread.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/screens/post_auth/messages/chat_screen.dart';
import 'package:local/screens/post_auth/messages/views/options/thread_options.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:timeago/timeago.dart';

class ChatThread extends StatefulWidget {
  const ChatThread({
    Key? key,
    required this.thread,
  }) : super(key: key);

  final Thread thread;

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends State<ChatThread> {
  Person me = andrew;
  bool selected = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = widget.thread.lastMessage.body;
    final other = widget.thread.person1.personID == me.personID
        ? widget.thread.person2
        : widget.thread.person1;

    return GestureDetector(
      onTapDown: (details) {
        if (mounted) {
          setState(() {
            selected = true;
          });
        }
      },
      onLongPress: () {
        showThreadOptionsModal(
          context,
        );
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
                child: Opacity(
                  opacity: widget.thread.isRead ? 0.7 : 1.0,
                  child: Image.asset(
                    other.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
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
                      other.name,
                      style: !widget.thread.isRead
                          ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: TW3Colors.gray.shade100,
                              )
                          : Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: TW3Colors.gray.shade400,
                              ),
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
                    Text(
                      format(widget.thread.lastMessage.sentAt),
                      style: !widget.thread.isRead
                          ? Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: TW3Colors.gray.shade100,
                              )
                          : Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: TW3Colors.gray.shade400,
                              ),
                    ),
                  ],
                ),
                Text(
                  body.length <= 50 ? body : "${body.substring(0, 50)}...",
                  style: !widget.thread.isRead
                      ? Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: TW3Colors.gray.shade100,
                          )
                      : Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: TW3Colors.gray.shade400,
                          ),
                )
              ],
            ),
            const Spacer(),
            CustomIconButton(
              tap: () {
                showThreadOptionsModal(
                  context,
                );
              },
              child: const HeroIcon(
                HeroIcons.ellipsisVertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
