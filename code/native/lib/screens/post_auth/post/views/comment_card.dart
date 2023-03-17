import 'package:flutter/material.dart';
import 'package:local/screens/post_auth/comment/comment_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const CommentScreen(
                commentID: 1,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                // avatar
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(16),
                    child: Image.asset("assets/avatars/fox_ai.png"),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text("Andrew",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "adasflkasjdflkasdjlfkajsdlkd sfjlasdk fjlasdkfj lasdkjf laskdfj lasdk fjlasdkjf lasdkjf lasdkfj lasdkfj alsdkjf lasdkjf lsdakj falsdjflsdj l",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.emoji_emotions,
                      color: TW3Colors.gray.shade300,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          width: 2,
                          color: TW3Colors.gray.shade800,
                        ),
                        color: TW3Colors.gray.shade700,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 20,
                            color: TW3Colors.gray.shade300,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("1"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Reply"),
                    ),
                  ],
                ),
                Text(
                  "4 hours ago",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
