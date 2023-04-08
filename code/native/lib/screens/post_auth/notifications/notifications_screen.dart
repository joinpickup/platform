import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/screens/post_auth/notifications/views/notifications_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

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
          title: const Text("Notifications"),
        ),
        body: Column(
          children: [
            _buildTabBar(),
            const NotificationsFeed(),
          ],
        ),
      ),
    );
  }

  CustomTabBar _buildTabBar() {
    return CustomTabBar(
      small: true,
      tabs: [
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "New",
          tab: 0,
          small: true,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Pending",
          tab: 1,
          small: true,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Archived",
          tab: 2,
          small: true,
        ),
      ],
    );
  }
}
