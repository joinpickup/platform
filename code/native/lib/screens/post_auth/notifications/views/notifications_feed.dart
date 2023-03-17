import 'package:flutter/material.dart';
import 'package:local/screens/post_auth/notifications/views/notification_card.dart';

class NotificationsFeed extends StatefulWidget {
  const NotificationsFeed({Key? key}) : super(key: key);

  @override
  State<NotificationsFeed> createState() => _NotificationsFeedState();
}

class _NotificationsFeedState extends State<NotificationsFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: const [
          NotificationsCard(),
          Divider(),
          NotificationsCard(),
          Divider(),
          NotificationsCard(),
          Divider(),
          NotificationsCard(),
          Divider(),
        ],
      ),
    );
  }
}
