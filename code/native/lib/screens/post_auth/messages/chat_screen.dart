import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/mocks/post.dart';
import 'package:local/repos/data/models/message/message.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/screens/post_auth/messages/views/options/chat_options.dart';
import 'package:local/screens/post_auth/messages/views/options/thread_options.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:local/screens/post_auth/post/post_screen.dart';
import 'package:local/screens/post_auth/post/views/post_mini.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

DateTime lastYear = DateTime.now().subtract(const Duration(days: 365));

DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

DateTime twentyMinutesAgo =
    DateTime.now().subtract(const Duration(minutes: 20));

DateTime tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));

DateTime fiveMinutesAgo = DateTime.now().subtract(const Duration(minutes: 5));

List<Message> messages = [
  Message(
    body: "Hey man",
    messageID: 0,
    sentAt: lastYear,
    sender: brian,
    receiver: andrew,
    post: andrewPost,
  ),
  Message(
    body: "Yo yo brian",
    messageID: 0,
    sentAt: yesterday,
    sender: andrew,
    receiver: brian,
  ),
  Message(
    body: "Hi brian",
    messageID: 1,
    sentAt: twentyMinutesAgo,
    sender: andrew,
    receiver: brian,
  ),
  Message(
    body: "why aren't you answering brian",
    messageID: 2,
    sentAt: tenMinutesAgo,
    sender: andrew,
    receiver: brian,
  ),
  Message(
    body: "cmon please",
    messageID: 3,
    sentAt: tenMinutesAgo,
    sender: andrew,
    receiver: brian,
  ),
  Message(
    body: "fine what's up",
    messageID: 3,
    sentAt: fiveMinutesAgo,
    sender: brian,
    receiver: andrew,
  ),
  Message(
    body: "miss you :)",
    messageID: 4,
    sentAt: DateTime.now(),
    sender: andrew,
    receiver: brian,
  )
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // temp state
  final me = andrew;
  final other = brian;

  // controllers
  final _messageController = TextEditingController();
  bool _isInputEmpty = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabBarBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: TW3Colors.gray.shade700,
        appBar: AppBar(
          backgroundColor: TW3Colors.gray.shade700,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showThreadOptionsModal(
                  context,
                );
              },
            ),
          ],
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return PersonScreen(
                    personID: other.personID,
                  );
                },
              ));
            },
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(14),
                    child: Image.asset(other.avatar, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(other.name),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // handle reversed index
                    index = messages.length - index - 1;

                    // lets build the message with the
                    // context of the other messages
                    Message? previousMessage;
                    Message? nextMessage;
                    final message = messages[index];

                    if (index > 0) {
                      previousMessage = messages[index - 1];
                    }

                    if (index < messages.length - 1) {
                      nextMessage = messages[index + 1];
                    }

                    bool messagesSentWithinSameMinutePrevious = false;
                    bool messagesSentWithinSameMinuteNext = false;
                    if (
                        // see if we have a next message
                        nextMessage != null &&

                            // if we do then lets see if its the same person
                            nextMessage.sender.personID ==
                                message.sender.personID &&

                            // if it is then lets see if it happened recently
                            nextMessage.sentAt
                                    .difference(message.sentAt)
                                    .abs()
                                    .inMinutes <=
                                2) {
                      messagesSentWithinSameMinuteNext = true;
                    }

                    if (
                        // see if we have a next message
                        previousMessage != null &&

                            // if we do then lets see if its the same person
                            previousMessage.sender.personID ==
                                message.sender.personID &&

                            // if it is then lets see if it happened recently
                            previousMessage.sentAt
                                    .difference(message.sentAt)
                                    .abs()
                                    .inMinutes <=
                                2) {
                      messagesSentWithinSameMinutePrevious = true;
                    }

                    bool messageNeedsDate = false;
                    bool messageThisYear =
                        message.sentAt.year == DateTime.now().year;
                    if (previousMessage == null ||
                        (previousMessage.sentAt.day != message.sentAt.day)) {
                      messageNeedsDate = true;
                    }

                    if (previousMessage == null ||
                        (previousMessage.sentAt.day != message.sentAt.day)) {
                      messageNeedsDate = true;
                    }

                    final isSender = message.sender.userID == andrew.userID;

                    // need to do some fancy formatting here eventually
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: messagesSentWithinSameMinutePrevious ? 4 : 4,
                        bottom: messagesSentWithinSameMinuteNext ? 0 : 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          messageNeedsDate
                              ? Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        DateFormat(
                                          !messageThisYear
                                              ? 'MMM d, y'
                                              : 'E, MMM d',
                                        ).format(message.sentAt),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: TW3Colors.gray.shade400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                )
                              : Container(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              message.post != null
                                  ? Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) {
                                                return PostScreen(
                                                  postID: message.post?.postID
                                                      as int,
                                                );
                                              },
                                            ));
                                          },
                                          child: PostMini(
                                            post: message.post as Post,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              MessageBubble(
                                message: messages[index],
                                isSender: isSender,
                                me: me,
                                messagesSentWithinSameMinuteNext:
                                    messagesSentWithinSameMinuteNext,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        controller: _messageController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (value) {
                          setState(() {
                            _isInputEmpty = value.isEmpty;
                          });
                        },
                        placeholder: "Send a message...",
                        padding: const EdgeInsets.all(12),
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
                          border: Border.all(
                            width: 2,
                            color: TW3Colors.gray.shade600,
                          ),
                          color: TW3Colors.gray.shade600,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    _isInputEmpty ? Container() : const SizedBox(width: 8.0),
                    _isInputEmpty
                        ? Container()
                        : CustomButton(
                            color: Theme.of(context).colorScheme.primary,
                            tap: () {
                              final messageText = _messageController.text;
                              sendMessage(messageText);
                              _messageController.clear();
                              setState(() {
                                _isInputEmpty = true;
                              });
                            },
                            child: const HeroIcon(
                              HeroIcons.arrowUp,
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage(String messageText) {
    final newMessage = Message(
      body: messageText,
      messageID: messages.length + 1,
      sentAt: DateTime.now(),
      sender: me,
      receiver: other,
    );

    // update thread temporarily
    setState(() {
      messages.add(newMessage);
    });
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isSender,
    required this.me,
    required this.messagesSentWithinSameMinuteNext,
  });

  final Message message;
  final bool isSender;
  final Person me;
  final bool messagesSentWithinSameMinuteNext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.mediumImpact();
        showChatOptionsModal(
          context,
        );
      },
      child: SizedBox(
        width: 200,
        child: Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: message.sender.userID == me.userID
                  ? Theme.of(context).colorScheme.secondary
                  : TW3Colors.gray.shade500,
            ),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                !messagesSentWithinSameMinuteNext
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            DateFormat('h:mm a').format(message.sentAt),
                            // messages[index].sentAt.minute.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 10,
                                    color: TW3Colors.gray.shade400),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
